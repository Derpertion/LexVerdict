from flask import Blueprint, render_template, redirect, url_for, flash, jsonify, request, make_response, current_app
from flask_login import current_user, login_required
from app.forms import SubpoenaForm
from sqlalchemy import text, func, or_
from sqlalchemy.exc import IntegrityError
from datetime import datetime, date, timedelta
from dateutil.relativedelta import relativedelta
from app.models import db, Subpoena, Person, Address, InvolvedParty, DenialComment, PinCode, LogTable, User, Resolution, DenialComment, Username, Password, Prosecutor, Offense, SubpoenaOffense
from app.forms import SubpoenaForm, PersonForm, ResolutionForm, CreateUserForm, OffenseForm
from app.utils import log_action
import random, string, re
from weasyprint import HTML, CSS
from collections import defaultdict
from werkzeug.security import generate_password_hash
import os, io

admin_bp = Blueprint('admin', __name__)

def generate_pin(length=6):
    return ''.join(random.choices(string.digits, k=length))

@admin_bp.route('/dashboard')
@login_required
def dashboard():
    return render_template('Admin/dashboard.html')

@admin_bp.route('/subpoenas')
@login_required
def subpoena_list():
    search_value = request.args.get("search", "").strip()
    search_column = request.args.get("filter", "")
    sort_by = request.args.get("sort", "Docket_Number")
    sort_order = request.args.get("order", "desc")
    page = request.args.get("page", 1, type=int)
    per_page = 6

    allowed_columns = [
        "Date_", "Verdict", "Complainant", "Respondent",
        "Crime", "Police_Station", "Prosecutor", "Docket_Number"
    ]

    base_sql = "FROM view_subpoena_list WHERE 1=1"
    where_sql = ""
    params = {}

    # SEARCH / FILTER
    if search_value:
        if search_column and search_column in allowed_columns:
            where_sql += f" AND {search_column} LIKE :search_value"
            params["search_value"] = f"%{search_value}%"
        else:
            where_sql += """
                AND (
                    Docket_Number LIKE :search_value OR
                    Crime LIKE :search_value OR
                    Complainant LIKE :search_value OR
                    Respondent LIKE :search_value OR
                    Police_Station LIKE :search_value OR
                    Prosecutor LIKE :search_value
                )
            """
            params["search_value"] = f"%{search_value}%"

    # SORT
    if sort_by not in allowed_columns:
        sort_by = "Docket_Number"
    order_clause = "ASC" if sort_order == "asc" else "DESC"

    # TOTAL COUNT
    count_sql = f"SELECT COUNT(*) {base_sql} {where_sql}"
    total = db.session.execute(text(count_sql), params).scalar()

    # PREVENT ZERO-PAGE BUG
    total_pages = max((total + per_page - 1) // per_page, 1)

    # CLAMP PAGE WITHIN VALID RANGE
    if page < 1:
        page = 1
    if page > total_pages:
        page = total_pages

    # PAGINATION
    data_sql = f"""
        SELECT *
        {base_sql}
        {where_sql}
        ORDER BY {sort_by} {order_clause}
        LIMIT :limit OFFSET :offset
    """

    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page

    subpoenas = db.session.execute(text(data_sql), params).mappings().all()

    return render_template("admin/subpoena_list.html",
        subpoenas=subpoenas,
        resolution_form=ResolutionForm(),
        current_sort=sort_by,
        current_order=sort_order,
        current_filter=search_column,
        current_search=search_value,
        page=page,
        total_pages=total_pages
    )

MAX_RESERVE_ATTEMPTS = 5

@admin_bp.route('/subpoenas/create', methods=['GET', 'POST'])
@login_required
def create_subpoena():
    form = SubpoenaForm()
    # load prosecutors as before
    prosecutors = db.session.execute(text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list WHERE archived=0")).fetchall()
    form.prosecutor_id.choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors] if prosecutors else []

    if form.validate_on_submit():
        # --- Age validation (precise) ---
        today = date.today()
        min_birth_date = today - relativedelta(years=18)

        for group_name, entries in {
            "Complainant": form.complainants.entries,
            "Respondent": form.respondents.entries
        }.items():
            for entry in entries:
                if entry.birth_date.data and entry.birth_date.data > min_birth_date:
                    flash(f"❌ {group_name} must be at least 18 years old.", "danger")
                    return render_template('admin/create_subpoena.html', form=form)

        # Normalize helper
        def norm_str(s):
            if s is None:
                return ""
            return s.strip()

        def norm_for_compare(s):
            # lowercase and strip for comparisons
            return norm_str(s).lower()

        # --- Create Subpoena with reserved docket serials (retry on race) ---
        crimes_selected = form.crimes.data or []
        crime_count = len([c for c in crimes_selected if c])
        if crime_count == 0:
            flash("Please select at least one crime.", "danger")
            return render_template('admin/create_subpoena.html', form=form)

        # The server computes the docket rather than trusting client; user provided date must be valid
        try:
            subpoena_date = form.date.data or date.today()
        except Exception:
            subpoena_date = date.today()

        # build prefix same way as API
        region = "III"
        office = "09"
        type_code = "INV"
        year_code = str(subpoena_date.year)[-2:]
        month_code = chr(65 + subpoena_date.month - 1)
        prefix = f"{region}-{office}-{type_code}-{year_code}{month_code}"

        # Reserve serials with retries to avoid race conditions
        attempt = 0
        last_err = None
        while attempt < MAX_RESERVE_ATTEMPTS:
            attempt += 1
            try:
                # read the current max serial for this prefix
                last_row = (
                db.session.query(Subpoena)
                .filter(Subpoena.Docket_Number.like(f"{prefix}-%"))
                .order_by(Subpoena.Docket_Number.desc())
                .with_for_update(read=True)
                .first()
                )

                if last_row:
                    try:
                        base_serial = int(last_row.Docket_Number.rsplit("-", 1)[-1])
                    except Exception:
                        base_serial = 0
                else:
                    base_serial = 0

                first_serial = base_serial + 1

                first_serial_str = str(first_serial).zfill(4)

                if crime_count > 1:
                    last_serial_calc = first_serial + (crime_count - 1)
                    last_serial_str = str(last_serial_calc).zfill(4)
                    serials = [first_serial_str, last_serial_str]
                else:
                    serials = [first_serial_str]

                combined_docket = prefix + "-" + "-".join(serials)

                # Build Subpoena object
                subpoena = Subpoena(
                    Docket_Number=combined_docket,
                    Date_=form.date.data,
                    Hearing_Date_1=form.hearing_date_1.data,
                    Hearing_Date_2=form.hearing_date_2.data,
                    Police_Station=form.police_station.data,
                    PROSECUTOR_ID=form.prosecutor_id.data
                )
                db.session.add(subpoena)
                db.session.flush()  # flush to assign relationships (but not commit yet)

                # --- Crimes linking: single subpoena, multiple SubpoenaOffense rows ---
                for crime_id in crimes_selected:
                    if not crime_id:
                        continue
                    try:
                        crime_id_int = int(crime_id)
                    except ValueError:
                        continue
                    offense = db.session.query(Offense).filter_by(offense_id=crime_id_int).first()
                    if offense:
                        link = SubpoenaOffense(
                            Docket_Number=subpoena.Docket_Number,
                            offense_id=offense.offense_id
                        )
                        db.session.add(link)

                # --- Generate and Save PIN ---
                pin = generate_pin()
                pin_entry = PinCode(PIN_CODE=pin, Docket_Number=subpoena.Docket_Number)
                db.session.add(pin_entry)

                # === Person/address helpers (normalize strings for compare) ===
                def get_or_create_person(first, middle, last, suffix, birth, sex):
                    f = norm_for_compare(first)
                    m = norm_for_compare(middle)
                    l = norm_for_compare(last)
                    sfx = norm_for_compare(suffix)
                    # For date, compare exact
                    person = db.session.query(Person).filter(
                        func.lower(Person.First_name) == f,
                        func.lower(Person.Middle_name) == m,
                        func.lower(Person.Last_name) == l,
                        func.coalesce(func.lower(Person.Suffix), '') == sfx,
                        Person.Date_of_Birth == birth,
                        Person.Sex == sex
                    ).first()
                    if not person:
                        person = Person(
                            First_name=norm_str(first),
                            Middle_name=norm_str(middle),
                            Last_name=norm_str(last),
                            Suffix=norm_str(suffix),
                            Date_of_Birth=birth,
                            Sex=sex
                        )
                        db.session.add(person)
                        db.session.flush()
                    return person

                def get_or_create_address(person_id, street, barangay, municipality, province, region):
                    st = norm_for_compare(street)
                    br = norm_for_compare(barangay)
                    mu = norm_for_compare(municipality)
                    pr = norm_for_compare(province)
                    rg = norm_for_compare(region)
                    address = db.session.query(Address).filter(
                        func.lower(Address.Street) == st,
                        func.lower(Address.Barangay) == br,
                        func.lower(Address.Municipality) == mu,
                        func.lower(Address.Province) == pr,
                        func.lower(Address.Region) == rg,
                        Address.PERSON_ID == person_id
                    ).first()
                    if not address:
                        address = Address(
                            Street=norm_str(street),
                            Barangay=norm_str(barangay),
                            Municipality=norm_str(municipality),
                            Province=norm_str(province),
                            Region=norm_str(region),
                            PERSON_ID=person_id
                        )
                        db.session.add(address)
                        db.session.flush()
                    return address

                def process_party(entries, role):
                    for entry in entries:
                        person = get_or_create_person(
                            entry.first_name.data,
                            entry.middle_name.data,
                            entry.last_name.data,
                            entry.suffix.data,
                            entry.birth_date.data,
                            entry.sex.data
                        )
                        get_or_create_address(
                            person.PERSON_ID,
                            entry.street.data,
                            entry.barangay.data,
                            entry.municipality.data,
                            entry.province.data,
                            entry.region.data
                        )
                        # Avoid duplicate involved rows
                        exists = db.session.query(InvolvedParty).filter_by(
                            PERSON_ID=person.PERSON_ID,
                            Docket_Number=subpoena.Docket_Number,
                            Role=role
                        ).first()
                        if not exists:
                            involved = InvolvedParty(
                                PERSON_ID=person.PERSON_ID,
                                Docket_Number=subpoena.Docket_Number,
                                Role=role
                            )
                            db.session.add(involved)

                process_party(form.complainants.entries, 'Complainant')
                process_party(form.respondents.entries, 'Respondent')

                # --- Log ---
                log = LogTable(
                    USER_ID=current_user.USER_ID,
                    Action=f"Created subpoena {subpoena.Docket_Number}",
                    Timestamp=datetime.now()
                )
                db.session.add(log)

                # final commit
                db.session.commit()
                flash("Subpoena created successfully!", "success")
                return redirect(url_for('admin.verify_cases'))

            except IntegrityError as ie:
                # Some unique constraint (likely Docket_Number) collided. Rollback and retry.
                db.session.rollback()
                last_err = ie
                # If max attempts reached, abort with an error message
                if attempt >= MAX_RESERVE_ATTEMPTS:
                    flash("Could not reserve docket number due to concurrent submissions. Please try again.", "danger")
                    return render_template('admin/create_subpoena.html', form=form)
                # otherwise, loop to try reserve new serials
                continue

            except Exception as e:
                db.session.rollback()
                # Unexpected error - show a message and log if you have a logger
                flash("An unexpected error occurred while creating subpoena.", "danger")
                # Optionally log e
                return render_template('admin/create_subpoena.html', form=form)

        # If we fell out of loop with last_err:
        flash("Failed to create subpoena. Please retry.", "danger")
        return render_template('admin/create_subpoena.html', form=form)

    # Default render
    return render_template('admin/create_subpoena.html', form=form, datetime=datetime, timedelta=timedelta)

@admin_bp.route('/api/next-serial')
def next_serial():
    region = request.args.get("region", "III")
    office = request.args.get("office", "09")
    type_code = request.args.get("type", "INV").upper()

    date_str = request.args.get("date")
    count = int(request.args.get("count", 1))

    try:
        date = datetime.strptime(date_str, "%Y-%m-%d")
    except (ValueError, TypeError):
        return jsonify({"error": "Invalid date format (expected YYYY-MM-DD)"}), 400

    year_code = str(date.year)[-2:]
    month_code = chr(65 + date.month - 1)
    prefix = f"{region}-{office}-{type_code}-{year_code}{month_code}"

    last = db.session.query(Subpoena)\
        .filter(Subpoena.Docket_Number.like(f"{prefix}-%"))\
        .order_by(Subpoena.Docket_Number.desc()).first()

    if last:
        try:
            last_serial = int(last.Docket_Number.rsplit("-", 1)[-1])
        except Exception:
            last_serial = 0
    else:
        last_serial = 0

    first_serial = last_serial + 1
    last_serial_calc = first_serial + (count - 1)

    serials = [str(first_serial).zfill(4)]
    if count > 1:
        serials.append(str(last_serial_calc).zfill(4))

    combined = prefix + "-" + "-".join(serials)
    per_crime_dockets = [f"{prefix}-{s}" for s in serials]

    return jsonify({
        "docket_combined": combined,
        "per_crime_dockets": per_crime_dockets,
        "serials": serials,
        "prefix": prefix
    })



@admin_bp.route('/verify')
@login_required
def verify_cases():

    # ============================
    # SUBPOENA PARAMS (independent)
    # ============================
    sub_page = request.args.get("sub_page", 1, type=int)
    sub_per_page = 5
    sub_search = request.args.get("sub_search", "").strip()
    sub_filter = request.args.get("sub_filter", "")
    sub_sort = request.args.get("sub_sort", "Docket_Number")
    sub_order = request.args.get("sub_order", "desc")

    # Allowed subpoena columns
    sub_allowed = [
        "Docket_Number", "Crimes", "Complainants", "Respondents",
        "Police_Station", "Prosecutor", "Created_By", "Date_"
    ]

    # Build SQL for subpoenas
    sub_sql = "SELECT * FROM view_verify_subpoenas"
    sub_params = {}

    if sub_search:
        if sub_filter in sub_allowed:
            sub_sql += f" WHERE {sub_filter} LIKE :sub_search"
        else:
            # Default search column
            sub_sql += " WHERE Docket_Number LIKE :sub_search"
        sub_params["sub_search"] = f"%{sub_search}%"

    # Validate sorting
    if sub_sort not in sub_allowed:
        sub_sort = "Docket_Number"

    sub_order_clause = "ASC" if sub_order == "asc" else "DESC"
    sub_sql += f" ORDER BY {sub_sort} {sub_order_clause}"

    # Count query
    sub_count_sql = f"SELECT COUNT(*) AS total FROM ({sub_sql}) AS subquery"
    sub_total = db.session.execute(text(sub_count_sql), dict(sub_params)).scalar()

    # Pagination
    sub_sql += " LIMIT :limit OFFSET :offset"
    sub_params["limit"] = sub_per_page
    sub_params["offset"] = (sub_page - 1) * sub_per_page

    subpoenas = db.session.execute(text(sub_sql), sub_params).mappings().all()
    sub_total_pages = (sub_total + sub_per_page - 1) // sub_per_page



    # =============================
    # RESOLUTION PARAMS (independent)
    # =============================
    res_page = request.args.get("res_page", 1, type=int)
    res_per_page = 5
    res_search = request.args.get("res_search", "").strip()
    res_filter = request.args.get("res_filter", "")
    res_sort = request.args.get("res_sort", "Docket_Number")
    res_order = request.args.get("res_order", "desc")

    # Allowed resolution columns
    res_allowed = [
        "Docket_Number", "Crimes", "Complainants", "Respondents",
        "Police_Station", "Prosecutor", "Created_By",
        "Verdict", "Verdict_Date", "Court"
    ]

    # Build SQL for resolutions
    res_sql = "SELECT * FROM view_verify_resolutions"
    res_params = {}

    if res_search:
        if res_filter in res_allowed:
            res_sql += f" WHERE {res_filter} LIKE :res_search"
        else:
            res_sql += " WHERE Docket_Number LIKE :res_search"
        res_params["res_search"] = f"%{res_search}%"

    # Validate sorting
    if res_sort not in res_allowed:
        res_sort = "Docket_Number"

    res_order_clause = "ASC" if res_order == "asc" else "DESC"
    res_sql += f" ORDER BY {res_sort} {res_order_clause}"

    # Count total rows
    res_count_sql = f"SELECT COUNT(*) AS total FROM ({res_sql}) AS subquery"
    res_total = db.session.execute(text(res_count_sql), dict(res_params)).scalar()

    # Pagination
    res_sql += " LIMIT :limit OFFSET :offset"
    res_params["limit"] = res_per_page
    res_params["offset"] = (res_page - 1) * res_per_page

    resolutions = db.session.execute(text(res_sql), res_params).mappings().all()
    res_total_pages = (res_total + res_per_page - 1) // res_per_page



    # =============================
    # RENDER
    # =============================
    return render_template("admin/verify.html",
        subpoenas=subpoenas,
        resolutions=resolutions,
        resolution_form=ResolutionForm(),
        subpoena_form=SubpoenaForm(),

        # Subpoena params
        sub_current_sort=sub_sort,
        sub_current_order=sub_order,
        sub_current_filter=sub_filter,
        sub_current_search=sub_search,
        sub_page=sub_page,
        sub_total_pages=sub_total_pages,

        # Resolution params
        res_current_sort=res_sort,
        res_current_order=res_order,
        res_current_filter=res_filter,
        res_current_search=res_search,
        res_page=res_page,
        res_total_pages=res_total_pages
    )



@admin_bp.route('/admin/verify/subpoena/<string:docket_number>/<string:action>', methods=['GET', 'POST'])
@login_required
def verify_subpoena(docket_number, action):
    subpoena = Subpoena.query.get(docket_number)

    if not subpoena:
        flash("Subpoena not found.", "danger")
        return redirect(url_for('admin.verify_cases'))

    if action == "approve":
        subpoena.Status = "Approved"
        db.session.commit()

        # Logging
        log_action(f"Approved subpoena {docket_number}")
        

        flash("Subpoena approved.", "success")

    elif action == "deny" and request.method == "POST":
        comment = request.form.get("comment")
        if not comment:
            flash("Comment is required to deny.", "danger")
            return redirect(url_for('admin.verify_cases'))

        subpoena.Status = "Denied"

        # Update if comment exists, otherwise insert
        denial = DenialComment.query.filter_by(Docket_Number=docket_number, Type="Subpoena").first()
        if denial:
            denial.Comment = comment
            denial.Created_By = current_user.USER_ID
        else:
            denial = DenialComment(
                Docket_Number=docket_number,
                Type="Subpoena",
                Comment=comment,
                Created_By=current_user.USER_ID
            )
            db.session.add(denial)

        db.session.commit()

        # Logging
        log_action(f"Denied subpoena {docket_number} with comment: {comment}")

        flash("Subpoena denied with comment.", "warning")

    else:
        flash("Invalid request.", "danger")

    return redirect(url_for('admin.verify_cases'))

def get_person_forms(docket_number, role):
    involved = InvolvedParty.query.filter_by(Docket_Number=docket_number, Role=role).all()
    forms = []

    for party in involved:
        person = Person.query.get(party.PERSON_ID)
        form = PersonForm(obj=person)
        forms.append(form)

    return forms

def update_subpoena(subpoena, form):
    subpoena.Case_Type = form.Case_Type.data
    subpoena.Issue_Date = form.Issue_Date.data
    subpoena.Status = "Pending"
    subpoena.PROSECUTOR_ID = form.Prosecutor_ID.data
    subpoena.Resolution = form.Resolution.data
    subpoena.Resolution_Date = form.Resolution_Date.data
    subpoena.Court_Location = form.Court_Location.data
    subpoena.Hearing_Schedule = form.Hearing_Schedule.data
    db.session.commit()

@admin_bp.route('/subpoenas/edit/<docket_number>', methods=['GET', 'POST'])
@login_required
def edit_subpoena(docket_number):
    form = SubpoenaForm()
    subpoena = Subpoena.query.get_or_404(docket_number)
    denial = DenialComment.query.filter_by(Docket_Number=docket_number).first()
    denial_comment = denial.Comment if denial else None

    # Load prosecutors for dropdown
    prosecutors = db.session.execute(
        db.text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list")
    ).fetchall()
    prosecutor_choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors]
    form.prosecutor_id.choices = [(-1, 'Select Prosecutor')] + prosecutor_choices

    # Load offenses for dropdown
    offenses = Offense.query.all()
    form.crimes.choices = [(int(o.offense_id), o.Name) for o in offenses]

    if request.method == 'POST':
        # Remove empty complainants/respondents
        form.complainants.entries = [
            e for e in form.complainants.entries 
            if str(e.first_name.data).strip() or str(e.last_name.data).strip()
        ]
        form.respondents.entries = [
            e for e in form.respondents.entries 
            if str(e.first_name.data).strip() or str(e.last_name.data).strip()
        ]

        if form.validate_on_submit():
            changes = []

            # Compare old vs new offenses
            old_offenses = {so.offense_id for so in subpoena.offenses}
            new_offenses = set(map(int, form.crimes.data)) if form.crimes.data else set()
            if old_offenses != new_offenses:
                old_names = [o.Name for o in Offense.query.filter(Offense.offense_id.in_(old_offenses))]
                new_names = [o.Name for o in Offense.query.filter(Offense.offense_id.in_(new_offenses))]
                changes.append(f"Crimes from {old_names} to {new_names}")

            # Compare and log other fields
            if subpoena.Date_ != form.date.data:
                changes.append(f"Date from '{subpoena.Date_}' to '{form.date.data}'")
            if subpoena.Hearing_Date_1 != form.hearing_date_1.data:
                changes.append(f"Hearing Date 1 from '{subpoena.Hearing_Date_1}' to '{form.hearing_date_1.data}'")
            if subpoena.Hearing_Date_2 != form.hearing_date_2.data:
                changes.append(f"Hearing Date 2 from '{subpoena.Hearing_Date_2}' to '{form.hearing_date_2.data}'")
            if subpoena.Police_Station != form.police_station.data:
                changes.append(f"Police Station from '{subpoena.Police_Station}' to '{form.police_station.data}'")
            if subpoena.PROSECUTOR_ID != form.prosecutor_id.data:
                changes.append(f"Prosecutor ID from '{subpoena.PROSECUTOR_ID}' to '{form.prosecutor_id.data}'")

            # Apply changes to subpoena
            subpoena.Date_ = form.date.data
            subpoena.Hearing_Date_1 = form.hearing_date_1.data
            subpoena.Hearing_Date_2 = form.hearing_date_2.data
            subpoena.Police_Station = form.police_station.data
            subpoena.PROSECUTOR_ID = form.prosecutor_id.data
            subpoena.Status = 'Pending'

            # Update offenses safely
            if old_offenses != new_offenses:
                db.session.query(SubpoenaOffense).filter_by(Docket_Number=docket_number).delete()
                for offense_id in new_offenses:
                    db.session.add(SubpoenaOffense(Docket_Number=docket_number, offense_id=offense_id))

            # Update parties (complainants/respondents)
            old_complainants = InvolvedParty.query.filter_by(Docket_Number=docket_number, Role='Complainant').all()
            old_respondents = InvolvedParty.query.filter_by(Docket_Number=docket_number, Role='Respondent').all()
            db.session.query(InvolvedParty).filter_by(Docket_Number=docket_number).delete()

            if len(old_complainants) != len(form.complainants.entries):
                changes.append(f"Complainant count changed from {len(old_complainants)} to {len(form.complainants.entries)}")
            if len(old_respondents) != len(form.respondents.entries):
                changes.append(f"Respondent count changed from {len(old_respondents)} to {len(form.respondents.entries)}")

            def process_person(entry, role):
                person = db.session.query(Person).filter(
                    func.lower(Person.First_name) == entry.first_name.data.lower(),
                    func.lower(Person.Middle_name) == entry.middle_name.data.lower(),
                    func.lower(Person.Last_name) == entry.last_name.data.lower(),
                    Person.Suffix == entry.suffix.data,
                    Person.Date_of_Birth == entry.birth_date.data,
                    Person.Sex == entry.sex.data
                ).first()
                new_created = False
                if not person:
                    person = Person(
                        First_name=entry.first_name.data,
                        Middle_name=entry.middle_name.data,
                        Last_name=entry.last_name.data,
                        Suffix=entry.suffix.data,
                        Date_of_Birth=entry.birth_date.data,
                        Sex=entry.sex.data
                    )
                    db.session.add(person)
                    db.session.flush()
                    new_created = True

                address = db.session.query(Address).filter(
                    Address.PERSON_ID == person.PERSON_ID,
                    func.lower(Address.Street) == entry.street.data.lower(),
                    func.lower(Address.Barangay) == entry.barangay.data.lower(),
                    func.lower(Address.Municipality) == entry.municipality.data.lower(),
                    func.lower(Address.Province) == entry.province.data.lower(),
                    func.lower(Address.Region) == entry.region.data.lower()
                ).first()
                if not address:
                    address = Address(
                        Street=entry.street.data,
                        Barangay=entry.barangay.data,
                        Municipality=entry.municipality.data,
                        Province=entry.province.data,
                        Region=entry.region.data,
                        PERSON_ID=person.PERSON_ID
                    )
                    db.session.add(address)

                involved = InvolvedParty(
                    PERSON_ID=person.PERSON_ID,
                    Docket_Number=docket_number,
                    Role=role
                )
                db.session.add(involved)

                full_name = f"{person.First_name} {person.Middle_name or ''} {person.Last_name} {person.Suffix or ''}".strip()
                if new_created:
                    changes.append(f"New {role}: {full_name}")
                else:
                    changes.append(f"{role} linked: {full_name}")

            for entry in form.complainants.entries:
                process_person(entry, 'Complainant')
            for entry in form.respondents.entries:
                process_person(entry, 'Respondent')

            db.session.commit()

            if changes:
                log_action(f"Edited Subpoena {docket_number}: " + "; ".join(changes))
            else:
                log_action(f"Edited Subpoena {docket_number} with no field changes.")

            flash("Subpoena updated and marked for re-verification.", "success")
            return redirect(url_for('admin.verify_subpoena', docket_number=docket_number, action='recheck'))
        else:
            flash("Validation failed. Please check your inputs.", "danger")

    else:
        form.docket_number.data = subpoena.Docket_Number
        form.crimes.data = [int(so.offense_id) for so in subpoena.offenses]  # multiple
        form.date.data = subpoena.Date_ if isinstance(subpoena.Date_, date) else datetime.strptime(subpoena.Date_, '%Y-%m-%d').date()
        if subpoena.Hearing_Date_1:
            form.hearing_date_1.data = subpoena.Hearing_Date_1 if isinstance(subpoena.Hearing_Date_1, datetime) else datetime.strptime(subpoena.Hearing_Date_1, '%Y-%m-%dT%H:%M')
        if subpoena.Hearing_Date_2:
            form.hearing_date_2.data = subpoena.Hearing_Date_2 if isinstance(subpoena.Hearing_Date_2, datetime) else datetime.strptime(subpoena.Hearing_Date_2, '%Y-%m-%dT%H:%M')
        form.police_station.data = subpoena.Police_Station
        form.prosecutor_id.data = subpoena.PROSECUTOR_ID

        populate_person_form(form.complainants, 'Complainant', docket_number)
        populate_person_form(form.respondents, 'Respondent', docket_number)

    return render_template("admin/edit_subpoena.html", form=form, denial=denial, denial_comment=denial_comment, datetime=datetime, timedelta=timedelta)



def process_person_entry(entry, role, docket_number):
    person = None

    # Case 1: Editing existing person
    if entry.person_id.data:
        person = Person.query.get(int(entry.person_id.data))
        if person:
            person.First_name = entry.first_name.data.strip()
            person.Middle_name = entry.middle_name.data.strip() or None
            person.Last_name = entry.last_name.data.strip()
            person.Suffix = entry.suffix.data or None
            person.Date_of_Birth = entry.birth_date.data
            person.Sex = entry.sex.data
    else:
        # Try to find person by content
        person = (
            db.session.query(Person)
            .filter_by(
                First_name=entry.first_name.data.strip(),
                Middle_name=entry.middle_name.data.strip() or None,
                Last_name=entry.last_name.data.strip(),
                Suffix = entry.suffix.data or None,
                Date_of_Birth=entry.birth_date.data,
                Sex=entry.sex.data,
            )
            .first()
        )
        if not person:
            person = Person(
                First_name=entry.first_name.data.strip(),
                Middle_name=entry.middle_name.data.strip() or None,
                Last_name=entry.last_name.data.strip(),
                Suffix = entry.suffix.data or None,
                Date_of_Birth=entry.birth_date.data,
                Sex=entry.sex.data,
            )
            db.session.add(person)
            db.session.flush()

    # Address update
    if entry.address_id.data:
        address = Address.query.get(int(entry.address_id.data))
        if address:
            address.Street = entry.street.data.strip()
            address.Barangay = entry.barangay.data.strip()
            address.Municipality = entry.municipality.data.strip()
            address.Province = entry.province.data.strip()
            address.Region = entry.region.data.strip()
    else:
        # Try to find address
        address = (
            db.session.query(Address)
            .filter_by(
                Street=entry.street.data.strip(),
                Barangay=entry.barangay.data.strip(),
                Municipality=entry.municipality.data.strip(),
                Province=entry.province.data.strip(),
                Region=entry.region.data.strip(),
                PERSON_ID=person.PERSON_ID,
            )
            .first()
        )
        if not address:
            address = Address(
                Street=entry.street.data.strip(),
                Barangay=entry.barangay.data.strip(),
                Municipality=entry.municipality.data.strip(),
                Province=entry.province.data.strip(),
                Region=entry.region.data.strip(),
                PERSON_ID=person.PERSON_ID,
            )
            db.session.add(address)
            db.session.flush()

    person.address = [address]
    db.session.flush()

    # Link person to the subpoena
    involved = InvolvedParty(Docket_Number=docket_number, PERSON_ID=person.PERSON_ID, Role=role)
    db.session.add(involved)


def populate_person_form(entries, role, docket_number):
    while len(entries):
        entries.pop_entry()

    involved = (
        db.session.query(InvolvedParty, Person)
        .join(Person, InvolvedParty.PERSON_ID == Person.PERSON_ID)
        .filter(InvolvedParty.Docket_Number == docket_number, InvolvedParty.Role == role)
        .all()
    )

    for inv, person in involved:
        # Only get one address for this person, and only the one they were using in this case
        address = (
            db.session.query(Address)
            .filter(Address.PERSON_ID == person.PERSON_ID)
            .order_by(Address.Address_ID.desc()) 
            .first()
        )
        if not address:
            continue  # skip if no address found

        entry = entries.append_entry()
        entry.person_id.data = person.PERSON_ID
        entry.address_id.data = address.Address_ID
        entry.first_name.data = person.First_name
        entry.middle_name.data = person.Middle_name
        entry.last_name.data = person.Last_name
        entry.suffix.data = person.Suffix
        entry.birth_date.data = person.Date_of_Birth
        entry.sex.data = person.Sex
        entry.street.data = address.Street
        entry.barangay.data = address.Barangay
        entry.municipality.data = address.Municipality
        entry.province.data = address.Province
        entry.region.data = address.Region

def find_or_create_person_with_address(first_name, middle_name, last_name, suffix, birth_date, sex, address_data):
    person = db.session.query(Person).filter_by(
        First_name=first_name.strip(),
        Middle_name=middle_name.strip(),
        Last_name=last_name.strip(),
        Suffix = suffix,
        Date_of_Birth=birth_date,
        Sex=sex
    ).first()

    if not person:
        person = Person(
            First_name=first_name,
            Middle_name=middle_name,
            Last_name=last_name,
            Suffix=suffix,
            Date_of_Birth=birth_date,
            Sex=sex
        )
        db.session.add(person)
        db.session.flush()

    address = db.session.query(Address).filter_by(
        PERSON_ID=person.PERSON_ID,
        Street=address_data.get("Street", "").strip(),
        Barangay=address_data.get("Barangay", "").strip(),
        Municipality=address_data.get("Municipality", "").strip(),
        Province=address_data.get("Province", "").strip(),
        Region=address_data.get("Region", "").strip()
    ).first()

    if not address:
        address = Address(
            PERSON_ID=person.PERSON_ID,
            Street=address_data.get("Street", ""),
            Barangay=address_data.get("Barangay", ""),
            Municipality=address_data.get("Municipality", ""),
            Province=address_data.get("Province", ""),
            Region=address_data.get("Region", "")
        )
        db.session.add(address)

    return person, address

@admin_bp.route('/resolution/update', methods=['POST'])
@login_required
def update_resolution():
    form = ResolutionForm()

    if form.validate_on_submit():
        docket_number = form.docket_number.data
        verdict = form.verdict.data

        if verdict == 'Pending':
            flash("Cannot submit resolution with 'Pending' as the verdict.", "danger")
            return redirect(url_for('admin.verify_cases'))

        court = form.court.data if verdict == 'For Filing' else None
        verdict_date = form.verdict_date.data or datetime.today().date()

        resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()

        if not resolution:
            # New resolution
            resolution = Resolution(
                Docket_Number=docket_number,
                Verdict=verdict,
                Court=court,
                Date_=verdict_date,
                Status='Pending'
            )
            db.session.add(resolution)
            db.session.commit()
            log_action(f"Created Resolution for {docket_number} with Verdict: {verdict}, Court: {court or 'N/A'}, Date: {verdict_date}")
        else:
            changes = []

            if resolution.Verdict != verdict:
                changes.append(f"Verdict from '{resolution.Verdict}' to '{verdict}'")
            if resolution.Court != court:
                changes.append(f"Court from '{resolution.Court}' to '{court}'")
            if resolution.Date_ != verdict_date:
                changes.append(f"Date from '{resolution.Date_}' to '{verdict_date}'")

            resolution.Verdict = verdict
            resolution.Court = court
            resolution.Date_ = verdict_date
            resolution.Status = 'Pending'

            db.session.commit()

            if changes:
                log_action(f"Edited Resolution for {docket_number}: " + "; ".join(changes))
            else:
                log_action(f"Re-submitted Resolution for {docket_number} with no field changes")

        flash('Resolution submitted for verification.', 'success')
        return redirect(url_for('admin.verify_cases'))

    flash('Failed to submit resolution. Please check inputs.', 'danger')
    return redirect(url_for('admin.verify_cases'))


@admin_bp.route("/admin/verify/resolution/<string:docket_number>/<string:action>", methods=["GET", "POST"])
@login_required
def verify_resolution(docket_number, action):
    resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()
    if not resolution:
        flash("Resolution not found.", "error")
        return redirect(url_for("admin.verify_cases"))

    if action == "approve":
        resolution.Status = "Approved"
        resolution.Date_ = datetime.today().date()
        db.session.commit()

        log_action(f"Approved Resolution for {docket_number}")
        flash("Resolution approved successfully.", "success")
        return redirect(url_for("admin.verify_cases"))

    elif action == "deny" and request.method == "POST":
        comment = request.form.get("comment", "").strip()

        if not comment:
            flash("Comment is required to deny the resolution.", "error")
            return redirect(url_for("admin.verify_cases"))

        resolution.Status = "Denied"
        db.session.commit()

        # Update if comment already exists
        denial_comment = DenialComment.query.filter_by(
            Docket_Number=docket_number,
            Type="Resolution"
        ).first()

        if denial_comment:
            denial_comment.Comment = comment
            denial_comment.Created_By = current_user.USER_ID
        else:
            denial_comment = DenialComment(
                Docket_Number=docket_number,
                Type="Resolution",
                Comment=comment,
                Created_By=current_user.USER_ID
            )
            db.session.add(denial_comment)

        db.session.commit()
        log_action(f"Denied Resolution for {docket_number} with comment: {comment}")
        flash("Resolution denied with comment.", "warning")
        return redirect(url_for("admin.verify_cases"))

    else:
        flash("Invalid action.", "error")
        return redirect(url_for("admin.verify_cases"))

@admin_bp.route("/edit_resolution", methods=["POST"])
@login_required
def edit_resolution():  
    form = ResolutionForm()

    # Override choices to exclude "Pending"
    form.verdict.choices = [('For Filing', 'For Filing'), ('Dismissed', 'Dismissed')]

    docket_number = request.form.get("docket_number")
    verdict = request.form.get("verdict")
    court = request.form.get("court") or None

    if verdict not in ['For Filing', 'Dismissed']:
        flash("Invalid verdict selection for editing.", "danger")
        return redirect(url_for("admin.verify_cases"))

    verdict_date = datetime.utcnow().date()
    resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()

    if not resolution:
        flash("Resolution not found.", "error")
        return redirect(url_for("admin.verify_cases"))

    changes = []

    if resolution.Verdict != verdict:
        changes.append(f"Verdict from '{resolution.Verdict}' to '{verdict}'")

    if (resolution.Court or '') != (court or ''):
        changes.append(f"Court from '{resolution.Court}' to '{court or 'N/A'}'")

    if resolution.Date_ != verdict_date:
        changes.append(f"Date from '{resolution.Date_}' to '{verdict_date}'")

    resolution.Verdict = verdict
    resolution.Court = court if verdict == "For Filing" else None
    resolution.Date_ = verdict_date
    resolution.Status = "Pending"

    db.session.commit()

    if changes:
        log_action(f"Edited Resolution for {docket_number}: " + "; ".join(changes))
    else:
        log_action(f"Re-submitted Resolution for {docket_number} with no changes")

    flash("Resolution resubmitted for verification.", "info")
    return redirect(url_for("admin.verify_cases"))

@admin_bp.route('/generate_subpoena_pdf/<docket_number>')
@login_required
def generate_subpoena_pdf(docket_number):
    subpoena = Subpoena.query.get_or_404(docket_number)
    prosecutor = subpoena.prosecutor.person if subpoena.prosecutor else None
    resolution = subpoena.resolution[0] if subpoena.resolution else None
    pin = subpoena.pin_code[0].PIN_CODE if subpoena.pin_code else None

    # === CRIME LIST HANDLING ===
    offenses = (
        db.session.query(Offense.Name)
        .join(SubpoenaOffense, Offense.offense_id == SubpoenaOffense.offense_id)
        .filter(SubpoenaOffense.Docket_Number == docket_number)
        .order_by(Offense.Name.asc())
        .all()
    )
    offense_names = [o.Name for o in offenses]
    
    if len(offense_names) == 0:
        crimes_display = "No Offense Listed"
    elif len(offense_names) == 1:
        crimes_display = offense_names[0]
    elif len(offense_names) == 2:
        crimes_display = f"{offense_names[0]} and <br>{offense_names[1]}"
    elif len(offense_names) == 3:
        crimes_display = f"{offense_names[0]}, <br>{offense_names[1]}, and <br>{offense_names[2]}"
    else:
        crimes_display = f"{offense_names[0]}, <br>{offense_names[1]}, <br>{offense_names[2]}, etc"

    # === PARTIES ===
    complainants = []
    respondents = []
    parties = InvolvedParty.query.filter_by(Docket_Number=docket_number).all()
    for party in parties:
        person = party.person
        address = person.address[0] if person.address else None
        if party.Role == 'Complainant':
            complainants.append((person, address))
        elif party.Role == 'Respondent':
            respondents.append((person, address))

    all_parties = complainants + respondents
    group_dict = defaultdict(list)
    for person, address in all_parties:
        if address:
            municipality_key = (address.Municipality or "unknown").strip().lower()
            group_dict[municipality_key].append((person, address))
        else:
            group_dict["unknown"].append((person, None))

    grouped_parties = []
    for municipality_key, party_list in group_dict.items():
        sample_address = next((addr for _, addr in party_list if addr), None)
        grouped_parties.append({
            'municipality': sample_address.Municipality.title() if sample_address else "Unknown",
            'province': sample_address.Province.title() if sample_address else "Unknown",
            'people': party_list
        })

    # === DATES & STAFF ===
    hearing_date_1 = subpoena.Hearing_Date_1
    hearing_date_2 = subpoena.Hearing_Date_2
    issue_date = subpoena.Date_ if subpoena.Date_ else datetime.utcnow()

    staff_name = "________________"
    if hasattr(current_user, 'person') and current_user.person:
        staff_name = f"{current_user.person.First_name} {current_user.person.Last_name} {current_user.person.Suffix or ''}"

    # === RENDER PER MUNICIPALITY ===
    full_html = ""
    for group in grouped_parties:
        rendered = render_template("admin/subpoena_preview.html",
            subpoena=subpoena,
            complainants=complainants,
            respondents=respondents,
            prosecutor=prosecutor,
            resolution=resolution,
            issue_date=issue_date,
            pin=pin,
            staff_name=staff_name,
            grouped_parties=[group],
            hearing_date_1=hearing_date_1,
            hearing_date_2=hearing_date_2,
            pin_code=pin,
            crimes_display=crimes_display
        )
        full_html += rendered + '<p style="page-break-after: always"></p>'

    # THE CRITICAL FIX (add base_url)
    pdf_file = HTML(
        string=full_html,
        base_url=current_app.static_folder
    ).write_pdf()

    response = make_response(pdf_file)
    response.headers['Content-Type'] = 'application/pdf'
    response.headers['Content-Disposition'] = f'inline; filename=subpoena_{docket_number}.pdf'
    return response



@admin_bp.route('/subpoenas/view/<docket_number>')
@login_required
def view_subpoena(docket_number):
    form = SubpoenaForm()
    subpoena = Subpoena.query.get_or_404(docket_number)

    # Load prosecutors
    prosecutors = db.session.execute(
        db.text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list")
    ).fetchall()
    form.prosecutor_id.choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors]

    # Populate form fields
    form.docket_number.data = subpoena.Docket_Number
    offenses = Offense.query.all()
    form.crimes.choices = [(int(o.offense_id), o.Name) for o in offenses]
    form.crimes.data = [int(so.offense_id) for so in subpoena.offenses]  
    form.date.data = subpoena.Date_
    form.hearing_date_1.data = subpoena.Hearing_Date_1
    form.hearing_date_2.data = subpoena.Hearing_Date_2
    form.police_station.data = subpoena.Police_Station
    form.prosecutor_id.data = subpoena.PROSECUTOR_ID

    # populate parties
    populate_person_form(form.complainants, 'Complainant', docket_number)
    populate_person_form(form.respondents, 'Respondent', docket_number)

    return render_template("admin/view_subpoena.html", form=form)


@admin_bp.route('/reports', methods=['GET', 'POST'])
@login_required
def reports():
    has_filters = any(request.args.values())

    # Base SQL (uses the view_reports view you created earlier)
    sql = """
        SELECT *
        FROM view_reports
        WHERE Verdict IN ('For Filing', 'Dismissed')
          AND Resolution_Status = 'Approved'
    """
    params = {}

    # Filters from request
    start_date = request.args.get('start_date')
    end_date = request.args.get('end_date')
    verdict = request.args.get('verdict')
    # Select2 uses multiple; accept ids or names
    raw_crimes = request.args.getlist('crime')  # can be [] if none
    station = request.args.get('station')
    sex = request.args.get('sex')
    age_group = request.args.get('age_group')

    # Date filter
    if start_date and end_date:
        try:
            start = datetime.strptime(start_date, "%Y-%m-%d").date()
            end = datetime.strptime(end_date, "%Y-%m-%d").date()
            sql += " AND Date_ BETWEEN :start AND :end"
            params["start"] = start
            params["end"] = end
        except ValueError:
            # ignore invalid dates
            pass

    # Verdict filter
    if verdict in ['For Filing', 'Dismissed']:
        sql += " AND Verdict = :verdict"
        params["verdict"] = verdict

    # Robust multi-crime handling (IDs or names)
    final_names = []
    if raw_crimes:
        # If single comma-separated string was submitted, split it
        if len(raw_crimes) == 1 and raw_crimes[0] and ',' in raw_crimes[0] and not raw_crimes[0].strip().isdigit():
            raw_crimes = [c.strip() for c in raw_crimes[0].split(',') if c.strip()]

        id_list = []
        name_list = []
        for item in raw_crimes:
            if not item:
                continue
            if str(item).isdigit():
                try:
                    id_list.append(int(item))
                except ValueError:
                    name_list.append(item)
            else:
                name_list.append(item)

        # Resolve IDs -> names if any IDs present
        if id_list:
            rows = db.session.query(Offense.offense_id, Offense.Name).filter(Offense.offense_id.in_(id_list)).all()
            # rows may be objects or tuples depending on model; extract names robustly
            resolved = []
            for r in rows:
                if hasattr(r, 'Name'):
                    resolved.append(r.Name)
                elif isinstance(r, (tuple, list)) and len(r) > 1:
                    resolved.append(r[1])
            name_list.extend([n for n in resolved if n])

        # Deduplicate preserving order
        seen = set()
        for n in name_list:
            if n not in seen:
                seen.add(n)
                final_names.append(n)

        # If there are final names, add them as LIKE filters against Crime (GROUP_CONCAT text)
        if final_names:
            crime_conditions = []
            for i, cname in enumerate(final_names):
                key = f"crime_{i}"
                crime_conditions.append(f"Crime LIKE :{key}")
                params[key] = f"%{cname}%"
            sql += " AND (" + " OR ".join(crime_conditions) + ")"

    # Police Station filter
    if station:
        sql += " AND Police_Station = :station"
        params["station"] = station

    # Execute main query on view_reports
    reports = db.session.execute(text(sql), params).mappings().all()

    # Optional demographic filters (sex / age_group) applied using person join
    if sex or age_group:
        dockets = [r["Docket_Number"] for r in reports]
        if dockets:
            q = (
                db.session.query(Subpoena)
                .filter(Subpoena.Docket_Number.in_(dockets))
                .join(Subpoena.involved_party)
                .join(InvolvedParty.person)
            )

            if sex:
                q = q.filter(Person.Sex == sex)

            if age_group:
                today = date.today()
                age_ranges = {
                    '0-17': (0, 17),
                    '18-30': (18, 30),
                    '31-45': (31, 45),
                    '46-60': (46, 60),
                    '61+': (61, 200)
                }
                min_a, max_a = age_ranges.get(age_group, (0, 200))
                min_date = today.replace(year=today.year - max_a)
                max_date = today.replace(year=today.year - min_a)
                q = q.filter(Person.Date_of_Birth.between(min_date, max_date))

            filtered_dockets = [s.Docket_Number for s in q.distinct().all()]
            reports = [r for r in reports if r["Docket_Number"] in filtered_dockets]

    # Aggregations for charts
    total_cases = len(reports)
    filed = sum(1 for r in reports if r["Verdict"] == 'For Filing')
    dismissed = sum(1 for r in reports if r["Verdict"] == 'Dismissed')

    crime_count = {}
    station_count = {}
    verdict_count = {}

    for r in reports:
        if r["Crime"]:
            for c in [x.strip() for x in r["Crime"].split(",") if x.strip()]:
                crime_count[c] = crime_count.get(c, 0) + 1

        if r["Police_Station"]:
            station_count[r["Police_Station"]] = station_count.get(r["Police_Station"], 0) + 1

        if r["Verdict"]:
            verdict_count[r["Verdict"]] = verdict_count.get(r["Verdict"], 0) + 1

    most_common_crime = max(crime_count.items(), key=lambda x: x[1])[0] if crime_count else None

    # If user selected crimes, limit the crime distribution chart to those crimes (and preserve order)
    if final_names:
        # keep only selected crimes that exist in crime_count
        filtered_crime_count = {name: crime_count.get(name, 0) for name in final_names if crime_count.get(name, 0) > 0}
        # If none of the selected crimes have counts (possible), fallback to showing selected names with 0
        if not filtered_crime_count:
            filtered_crime_count = {name: 0 for name in final_names}
        crime_chart_source = filtered_crime_count
        # Build the "Top Case Selected" label text
        top_case_selected = ", ".join(final_names[:3]) + (" etc" if len(final_names) > 3 else "")
    else:
        crime_chart_source = crime_count
        top_case_selected = None

    # Verdict / Sex / Age distributions — calculate percentages
    def pct_and_list(counter):
        total = sum(counter.values()) or 0
        out = []
        for k, v in counter.items():
            pct = (v / total * 100) if total else 0
            out.append({'label': k, 'count': v, 'percent': round(pct, 1)})
        return out

    verdict_list = pct_and_list(verdict_count)
    sex_list = pct_and_list({k: v for k, v in ( (k, v) for k, v in ( (s.Sex, 0) for s in [] ) )})  # placeholder
    # build sex_list correctly from earlier sex_count
    sex_count = {}
    age_count = {}
    if reports:
        dockets = [r["Docket_Number"] for r in reports]
        parties = (
            db.session.query(Person)
            .join(InvolvedParty, InvolvedParty.PERSON_ID == Person.PERSON_ID)
            .filter(InvolvedParty.Docket_Number.in_(dockets))
            .all()
        )
        for p in parties:
            sex_count[p.Sex] = sex_count.get(p.Sex, 0) + 1
            if p.Date_of_Birth:
                age = date.today().year - p.Date_of_Birth.year - (
                    (date.today().month, date.today().day) < (p.Date_of_Birth.month, p.Date_of_Birth.day)
                )
                # bucket
                if age <= 17:
                    age_count['0-17'] = age_count.get('0-17', 0) + 1
                elif age <= 30:
                    age_count['18-30'] = age_count.get('18-30', 0) + 1
                elif age <= 45:
                    age_count['31-45'] = age_count.get('31-45', 0) + 1
                elif age <= 60:
                    age_count['46-60'] = age_count.get('46-60', 0) + 1
                else:
                    age_count['61+'] = age_count.get('61+', 0) + 1

    verdict_list = pct_and_list(verdict_count)
    sex_list = pct_and_list(sex_count)
    age_list = pct_and_list(age_count)
    crime_chart_list = [{'label': k, 'count': v} for k, v in crime_chart_source.items()]

    # Prepare all_crimes list for the Select2 tag dropdown
    all_crimes = [o.Name for o in Offense.query.order_by(Offense.Name).all()]

    return render_template(
        'Admin/reports.html',
        total_cases=total_cases,
        filed=filed,
        dismissed=dismissed,
        most_common_crime=most_common_crime,
        top_case_selected=top_case_selected,
        bar_chart_data=crime_chart_list,
        verdict_data=verdict_list,
        sex_data=sex_list,
        age_data=age_list,
        station_data=sorted(
            [{'label': k, 'count': v} for k, v in station_count.items()],
            key=lambda x: -x['count']
        )[:5],
        filters=request.args,
        has_filters=has_filters,
        all_crimes=all_crimes
    )

@admin_bp.route('/reports/pdf', methods=['POST'])
@login_required
def reports_pdf():
    """
    Accepts form POST containing filters and JSON array 'charts' with base64 images.
    Generates a dashboard-style PDF (side-by-side) using WeasyPrint.
    """
    import io, json
    from sqlalchemy import text
    from datetime import datetime, date
    from weasyprint import HTML, CSS
    from flask import make_response

    # Read filters from form (POST)
    start_date = request.form.get('start_date')
    end_date = request.form.get('end_date')
    verdict = request.form.get('verdict')
    raw_crimes = request.form.getlist('crime')  
    station = request.form.get('station')
    sex = request.form.get('sex')
    age_group = request.form.get('age_group')

    # Parse chart images JSON (list of data-uris)
    charts_json = request.form.get('charts')
    try:
        chart_images = json.loads(charts_json) if charts_json else []
        # ensure strings only
        chart_images = [c for c in chart_images if isinstance(c, str) and c.startswith('data:image')]
    except Exception:
        chart_images = []

    # Build and run the same SQL as /reports (kept consistent)
    sql = """
        SELECT *
        FROM view_reports
        WHERE Verdict IN ('For Filing', 'Dismissed')
          AND Resolution_Status = 'Approved'
    """
    params = {}

    # Date filter
    if start_date and end_date:
        try:
            start = datetime.strptime(start_date, "%Y-%m-%d").date()
            end = datetime.strptime(end_date, "%Y-%m-%d").date()
            sql += " AND Date_ BETWEEN :start AND :end"
            params["start"] = start
            params["end"] = end
        except ValueError:
            pass

    # Verdict filter
    if verdict in ['For Filing', 'Dismissed']:
        sql += " AND Verdict = :verdict"
        params["verdict"] = verdict

    # Crime handling (IDs or names)
    final_names = []
    if raw_crimes:
        # allow single comma-separated string posted as one item
        if len(raw_crimes) == 1 and raw_crimes[0] and ',' in raw_crimes[0] and not raw_crimes[0].strip().isdigit():
            raw_crimes = [c.strip() for c in raw_crimes[0].split(',') if c.strip()]

        id_list, name_list = [], []
        for item in raw_crimes:
            if not item:
                continue
            if str(item).isdigit():
                try:
                    id_list.append(int(item))
                except Exception:
                    name_list.append(item)
            else:
                name_list.append(item)

        if id_list:
            rows = db.session.query(Offense.offense_id, Offense.Name).filter(Offense.offense_id.in_(id_list)).all()
            resolved = []
            for r in rows:
                if hasattr(r, 'Name'):
                    resolved.append(r.Name)
                elif isinstance(r, (tuple, list)) and len(r) > 1:
                    resolved.append(r[1])
            name_list.extend([n for n in resolved if n])

        # dedupe preserve order
        seen = set()
        for n in name_list:
            n2 = n.strip()
            if n2 and n2 not in seen:
                seen.add(n2)
                final_names.append(n2)

        if final_names:
            crime_conditions = []
            for i, cname in enumerate(final_names):
                key = f"crime_{i}"
                crime_conditions.append(f"Crime LIKE :{key}")
                params[key] = f"%{cname}%"
            sql += " AND (" + " OR ".join(crime_conditions) + ")"

    # Station filter
    if station:
        sql += " AND Police_Station = :station"
        params["station"] = station

    # Execute
    reports = db.session.execute(text(sql), params).mappings().all()

    # Demographic filters using person join (mirror /reports)
    if sex or age_group:
        dockets = [r["Docket_Number"] for r in reports]
        if dockets:
            q = (
                db.session.query(Subpoena)
                .filter(Subpoena.Docket_Number.in_(dockets))
                .join(Subpoena.involved_party)
                .join(InvolvedParty.person)
            )
            if sex:
                q = q.filter(Person.Sex == sex)
            if age_group:
                today = date.today()
                age_ranges = {
                    '0-17': (0, 17),
                    '18-30': (18, 30),
                    '31-45': (31, 45),
                    '46-60': (46, 60),
                    '61+': (61, 200)
                }
                min_a, max_a = age_ranges.get(age_group, (0, 200))
                min_date = today.replace(year=today.year - max_a)
                max_date = today.replace(year=today.year - min_a)
                q = q.filter(Person.Date_of_Birth.between(min_date, max_date))

            filtered_dockets = [s.Docket_Number for s in q.distinct().all()]
            reports = [r for r in reports if r["Docket_Number"] in filtered_dockets]

    # Aggregations
    total_cases = len(reports)
    filed = sum(1 for r in reports if r["Verdict"] == 'For Filing')
    dismissed = sum(1 for r in reports if r["Verdict"] == 'Dismissed')

    crime_count = {}
    station_count = {}
    verdict_count = {}

    for r in reports:
        if r["Crime"]:
            for c in [x.strip() for x in r["Crime"].split(",") if x.strip()]:
                crime_count[c] = crime_count.get(c, 0) + 1
        if r["Police_Station"]:
            station_count[r["Police_Station"]] = station_count.get(r["Police_Station"], 0) + 1
        if r["Verdict"]:
            verdict_count[r["Verdict"]] = verdict_count.get(r["Verdict"], 0) + 1

    most_common_crime = max(crime_count.items(), key=lambda x: x[1])[0] if crime_count else None

    def pct(counter):
        s = sum(counter.values()) or 1
        return [{'label': k, 'count': v, 'percent': round(v / s * 100, 1)} for k, v in counter.items()]

    bar_chart_data = [{'label': k, 'count': v} for k, v in crime_count.items()]
    verdict_data = pct(verdict_count)

    # build sex/age from persons
    sex_count, age_count = {}, {}
    if reports:
        dockets = [r["Docket_Number"] for r in reports]
        parties = (
            db.session.query(Person)
            .join(InvolvedParty, InvolvedParty.PERSON_ID == Person.PERSON_ID)
            .filter(InvolvedParty.Docket_Number.in_(dockets))
            .all()
        )
        for p in parties:
            sex_count[p.Sex] = sex_count.get(p.Sex, 0) + 1
            if p.Date_of_Birth:
                age = date.today().year - p.Date_of_Birth.year - (
                    (date.today().month, date.today().day) < (p.Date_of_Birth.month, p.Date_of_Birth.day)
                )
                if age <= 17:
                    age_count['0-17'] = age_count.get('0-17', 0) + 1
                elif age <= 30:
                    age_count['18-30'] = age_count.get('18-30', 0) + 1
                elif age <= 45:
                    age_count['31-45'] = age_count.get('31-45', 0) + 1
                elif age <= 60:
                    age_count['46-60'] = age_count.get('46-60', 0) + 1
                else:
                    age_count['61+'] = age_count.get('61+', 0) + 1

    sex_data = pct(sex_count)
    age_data = pct(age_count)

    # Build filters text
    filters_display = []
    if start_date and end_date:
        filters_display.append(f"Date: {start_date} to {end_date}")
    if verdict:
        filters_display.append(f"Verdict: {verdict}")
    if final_names:
        filters_display.append(f"Case Type: {', '.join(final_names)}")
    if station:
        filters_display.append(f"Police Station: {station}")
    if sex:
        filters_display.append(f"Sex: {sex}")
    if age_group:
        filters_display.append(f"Age Group: {age_group}")
    generated_text = "; ".join(filters_display) if filters_display else "All Records"

    # visibility flags
    show_crime_sections = not bool(final_names)
    hide_sex = bool(sex)
    hide_age = bool(age_group)
    hide_station = bool(station)

    # render print template (dashboard-like)
    rendered = render_template(
        'Admin/reports_print.html',
        total_cases=total_cases,
        filed=filed,
        dismissed=dismissed,
        most_common_crime=most_common_crime,
        bar_chart_data=bar_chart_data,
        verdict_data=verdict_data,
        sex_data=sex_data,
        age_data=age_data,
        station_data=sorted([{'label': k, 'count': v} for k, v in station_count.items()], key=lambda x: -x['count']),
        generated_text=generated_text,
        chart_images=chart_images,
        show_crime_sections=show_crime_sections,
        hide_sex=hide_sex,
        hide_age=hide_age,
        hide_station=hide_station,
    )

    css = CSS(string='''
        @page { size: A4 landscape; margin: 12mm; }
        body { font-family: "Segoe UI", Arial, sans-serif; font-size: 11px; color: #222; }
        h1,h2 { color:#2a1d76; margin:0 0 6px 0; }
        .row { display: table; width:100%; table-layout: fixed; }
        .col { display: table-cell; vertical-align: top; padding:8px; }
        .left { width:260px; }
        .center { width: calc(100% - 260px - 360px); } /* adjust summary column width */
        .right { width:360px; }
        .card { background:#fff; padding:10px; border-radius:6px; border:1px solid #eee; margin-bottom:8px; }
        .chart-img { max-width:100%; height:auto; display:block; margin:6px 0; }
        table.summary { width:100%; border-collapse:collapse; }
        table.summary th { background:#2a1d76; color:#fff; padding:6px; text-align:left; }
        table.summary td { padding:6px; border:1px solid #eee; }
    ''')

    pdf_io = io.BytesIO()
    HTML(string=rendered).write_pdf(target=pdf_io, stylesheets=[css])
    pdf_io.seek(0)
    resp = make_response(pdf_io.read())
    resp.headers['Content-Type'] = 'application/pdf'
    resp.headers['Content-Disposition'] = 'inline; filename=lexverdict_report.pdf'
    return resp


@admin_bp.route('/manage-users')
@login_required
def manage_users():
    sort_by = request.args.get('sort', 'USER_ID')
    order = request.args.get('order', 'asc')
    search = request.args.get('search', '').strip()
    filter_by = request.args.get('filter', '')
    page = request.args.get("page", 1, type=int)
    per_page = 6 


    valid_fields = ['USER_ID', 'Full_Name', 'Role', 'Username']
    if sort_by not in valid_fields:
        sort_by = 'USER_ID'
    if order not in ['asc', 'desc']:
        order = 'asc'

    # Base query
    base_query = "SELECT * FROM view_manage_users WHERE Status COLLATE utf8mb4_general_ci = 'Active'"
    conditions = []
    params = {}

    # Search filter
    if search:
        if filter_by in valid_fields:
            conditions.append(f"{filter_by} LIKE :search")
        else:
            # search all fields
            conditions.append("(" + " OR ".join([f"{field} LIKE :search" for field in valid_fields]) + ")")
        params['search'] = f"%{search}%"

    # Apply WHERE if needed
    if conditions:
        base_query += " AND " + " AND ".join(conditions)

    # Apply ORDER BY
    base_query += f" ORDER BY {sort_by} {order}"

    # Count total rows first
    count_sql = f"SELECT COUNT(*) as total FROM ({base_query}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    # Apply pagination
    base_query += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page 

    users = db.session.execute(text(base_query), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template('Admin/manage_user.html',
        users=users,
        current_sort=sort_by,
        current_order=order,
        current_search=search,
        current_filter=filter_by,
        page=page,
        total_pages=total_pages)

@admin_bp.route('/create_user', methods=['GET', 'POST'])
@login_required
def create_user():
    from werkzeug.security import generate_password_hash

    form = CreateUserForm()

    if form.validate_on_submit():
        # Check if username already exists
        existing_username = Username.query.filter_by(Username=form.username.data).first()
        if existing_username:
            flash('Username already exists. Please choose another.', 'danger')
            return render_template('admin/create_user.html', form=form)

        # === Create Person ===
        person = Person(
            First_name=form.first_name.data,
            Last_name=form.last_name.data,
            Middle_name=form.middle_name.data,
            Suffix=form.suffix.data,
            Date_of_Birth=form.birth_date.data,
            Sex=form.sex.data
        )
        db.session.add(person)
        db.session.flush() 

        # === Address ===
        address = Address(
            PERSON_ID=person.PERSON_ID,
            Street=form.street.data,
            Barangay=form.barangay.data,
            Municipality=form.municipality.data,
            Province=form.province.data,
            Region=form.region.data
        )
        db.session.add(address)

        # === User ===
        user = User(
            PERSON_ID=person.PERSON_ID,
            Role=form.role.data
        )
        db.session.add(user)
        db.session.flush()  # Get USER_ID

        # === Username ===
        username = Username(
            USER_ID=user.USER_ID,
            Username=form.username.data
        )
        db.session.add(username)

        # === Password ===
        password = Password(
            USER_ID=user.USER_ID,
            Password=generate_password_hash(form.password.data)
        )
        db.session.add(password)

        # === Prosecutor Info ===
        if form.role.data == 'Prosecutor':
            prosecutor = Prosecutor(
                PERSON_ID=person.PERSON_ID,
                Licens_No=form.license_no.data,
                Office_No=form.office_no.data
            )
            db.session.add(prosecutor)

        db.session.commit()

        # === Logging ===
        full_name = f"{person.First_name} {person.Middle_name or ''} {person.Last_name} {person.Suffix or ''}".strip()
        log_action(f"Created new user: {full_name} with role '{user.Role}' and username '{username.Username}'")

        flash('User successfully created!', 'success')
        return redirect(url_for('admin.manage_users'))

    return render_template('admin/create_user.html', form=form)



@admin_bp.route('/edit_user/<int:user_id>', methods=['GET', 'POST'])
@login_required
def edit_user(user_id):
    from werkzeug.security import generate_password_hash

    user = User.query.get_or_404(user_id)
    person = user.person
    username_obj = user.username[0] if user.username else None
    password_obj = user.password[0] if user.password else None
    address = person.address[0] if person.address else None
    prosecutor = Prosecutor.query.filter_by(PERSON_ID=person.PERSON_ID).first()

    form = CreateUserForm()

    # Pre-fill the form on GET
    if request.method == 'GET':
        form.first_name.data = person.First_name
        form.last_name.data = person.Last_name
        form.middle_name.data = person.Middle_name
        form.suffix.data = person.Suffix
        form.birth_date.data = person.Date_of_Birth
        form.sex.data = person.Sex

        if address:
            form.street.data = address.Street
            form.barangay.data = address.Barangay
            form.municipality.data = address.Municipality
            form.province.data = address.Province
            form.region.data = address.Region

        form.role.data = user.Role
        form.username.data = username_obj.Username if username_obj else ""

        # ✅ Prefill prosecutor fields if role is Prosecutor
        if user.Role == 'Prosecutor' and prosecutor:
            form.license_no.data = prosecutor.Licens_No
            form.office_no.data = prosecutor.Office_No

    if form.validate_on_submit():
        existing_username = Username.query.filter(
            Username.Username == form.username.data,
            Username.USER_ID != user.USER_ID
        ).first()

        if existing_username:
            flash('Username already exists. Please choose another.', 'danger')
            return render_template('admin/edit_user.html', form=form)
        
        changes = []

        # === PERSON INFO ===
        if person.First_name != form.first_name.data:
            changes.append(f"First Name from '{person.First_name}' to '{form.first_name.data}'")
            person.First_name = form.first_name.data
        if person.Last_name != form.last_name.data:
            changes.append(f"Last Name from '{person.Last_name}' to '{form.last_name.data}'")
            person.Last_name = form.last_name.data
        if person.Middle_name != form.middle_name.data:
            changes.append(f"Middle Name from '{person.Middle_name}' to '{form.middle_name.data}'")
            person.Middle_name = form.middle_name.data
        if person.Suffix != form.suffix.data:
            changes.append(f"Suffix from '{person.Suffix}' to '{form.suffix.data}'")
            person.Suffix = form.suffix.data
        if person.Date_of_Birth != form.birth_date.data:
            changes.append(f"Birth Date from '{person.Date_of_Birth}' to '{form.birth_date.data}'")
            person.Date_of_Birth = form.birth_date.data
        if person.Sex != form.sex.data:
            changes.append(f"Sex from '{person.Sex}' to '{form.sex.data}'")
            person.Sex = form.sex.data

        # === ADDRESS ===
        if address:
            if address.Street != form.street.data:
                changes.append(f"Street from '{address.Street}' to '{form.street.data}'")
                address.Street = form.street.data
            if address.Barangay != form.barangay.data:
                changes.append(f"Barangay from '{address.Barangay}' to '{form.barangay.data}'")
                address.Barangay = form.barangay.data
            if address.Municipality != form.municipality.data:
                changes.append(f"Municipality from '{address.Municipality}' to '{form.municipality.data}'")
                address.Municipality = form.municipality.data
            if address.Province != form.province.data:
                changes.append(f"Province from '{address.Province}' to '{form.province.data}'")
                address.Province = form.province.data
            if address.Region != form.region.data:
                changes.append(f"Region from '{address.Region}' to '{form.region.data}'")
                address.Region = form.region.data
        else:
            new_address = Address(
                PERSON_ID=person.PERSON_ID,
                Street=form.street.data,
                Barangay=form.barangay.data,
                Municipality=form.municipality.data,
                Province=form.province.data,
                Region=form.region.data
            )
            db.session.add(new_address)
            changes.append("Added new address")

        # === ROLE ===
        if user.Role != form.role.data:
            changes.append(f"Role from '{user.Role}' to '{form.role.data}'")
            user.Role = form.role.data

        # === USERNAME ===
        if username_obj:
            if username_obj.Username != form.username.data:
                changes.append(f"Username from '{username_obj.Username}' to '{form.username.data}'")
                username_obj.Username = form.username.data
        else:
            new_username = Username(USER_ID=user.USER_ID, Username=form.username.data)
            db.session.add(new_username)
            changes.append("Added new username")

        # === PASSWORD ===
        if form.password.data:
            new_pw_hash = generate_password_hash(form.password.data)
            if password_obj:
                password_obj.Password = new_pw_hash
                changes.append("Updated password")
            else:
                db.session.add(Password(USER_ID=user.USER_ID, Password=new_pw_hash))
                changes.append("Added new password")

        # === PROSECUTOR INFO ===
        if form.role.data == 'Prosecutor':
            if prosecutor:
                if prosecutor.Licens_No != form.license_no.data:
                    changes.append(f"License No from '{prosecutor.Licens_No}' to '{form.license_no.data}'")
                    prosecutor.Licens_No = form.license_no.data
                if prosecutor.Office_No != form.office_no.data:
                    changes.append(f"Office No from '{prosecutor.Office_No}' to '{form.office_no.data}'")
                    prosecutor.Office_No = form.office_no.data
            else:
                new_prosecutor = Prosecutor(
                    PERSON_ID=person.PERSON_ID,
                    Licens_No=form.license_no.data,
                    Office_No=form.office_no.data
                )
                db.session.add(new_prosecutor)
                changes.append("Added new prosecutor info")

        elif prosecutor:  
            # If user role changed away from Prosecutor, remove prosecutor record
            db.session.delete(prosecutor)
            changes.append("Removed prosecutor info (role changed)")

        db.session.commit()

        # === LOG CHANGES ===
        if changes:
            full_name = f"{person.First_name} {person.Middle_name or ''} {person.Last_name} {person.Suffix or ''}".strip()
            log_action(f"Edited user '{full_name}': " + "; ".join(changes))

        flash('User updated successfully!', 'success')
        return redirect(url_for('admin.manage_users'))

    return render_template('admin/edit_user.html', form=form)


@admin_bp.route('/delete_user/<int:user_id>', methods=['GET'])
@login_required
def delete_user(user_id):
    user = User.query.get_or_404(user_id)

    # Capture info for logging before deletion
    full_name = "Unknown"
    username = "Unknown"
    role = user.Role

    if user.person:
        full_name = f"{user.person.First_name} {user.person.Middle_name or ''} {user.person.Last_name} {user.person.Suffix or ''}".strip()
    if user.username:
        username = user.username[0].Username

    # Delete related data
    for pw in user.password:
        db.session.delete(pw)
    for uname in user.username:
        db.session.delete(uname)
    if user.person:
        for addr in user.person.address:
            db.session.delete(addr)
        db.session.delete(user.person)

    db.session.delete(user)
    db.session.commit()

    log_action(f"Deleted user: {full_name} (Username: {username}, Role: {role})")

    flash('User removed successfully.', 'success')
    return redirect(url_for('admin.manage_users'))


@admin_bp.route('/user_logs')
@login_required
def user_logs():
    search = request.args.get('search', '')
    filter_column = request.args.get('filter', '')
    sort_column = request.args.get('sort', 'Timestamp')
    sort_order = request.args.get('order', 'desc')
    page = request.args.get("page", 1, type=int)
    per_page = 10

    allowed_columns = ['LOG_ID', 'USER_ID', 'Full_Name', 'Role', 'Action', 'Timestamp']
    if sort_column not in allowed_columns:
        sort_column = 'Timestamp'
    if filter_column and filter_column not in allowed_columns:
        filter_column = ''

    base_query = "SELECT * FROM view_user_logs"
    where_clause = ""
    params = {}

    if search and filter_column:
        where_clause = f"WHERE {filter_column} LIKE :search"
        params['search'] = f"%{search}%"
    elif search:
        where_clause = "WHERE Full_Name LIKE :search OR Role LIKE :search OR Action LIKE :search"
        params['search'] = f"%{search}%"

    final_query = f"{base_query} {where_clause} ORDER BY {sort_column} {sort_order.upper()}"
    
    # Count total rows first
    count_sql = f"SELECT COUNT(*) as total FROM ({final_query}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    # Apply pagination
    final_query += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page 

    log = db.session.execute(text(final_query), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template('admin/user_logs.html',
        log=log,
        current_search=search,
        current_filter=filter_column,
        current_sort=sort_column,
        current_order=sort_order,
        page=page,
        total_pages=total_pages
    )

@admin_bp.route('/search_offense')
@login_required
def search_offense():
    raw = request.args.get('q', '').strip()
    if not raw:
        return jsonify([])

    # Python-side normalization
    raw_lower = raw.lower()
    raw_nopunct = re.sub(r'[^\w\s]', '', raw_lower)      
    raw_nospace = re.sub(r'\s+', '', raw_nopunct)      

    # DB-side normalized expressions (lowercase + strip common punctuation/space/hyphen)
    name_lower = db.func.lower(Offense.Name)
    name_nopunct = db.func.replace(db.func.replace(db.func.replace(name_lower, '.', ''), ' ', ''), '-', '')
    law_lower = db.func.lower(Offense.Law_Reference)
    law_nopunct = db.func.replace(db.func.replace(db.func.replace(law_lower, '.', ''), ' ', ''), '-', '')

    # Like patterns we will search for
    like_raw = f"%{raw}%"
    like_raw_lower = f"%{raw_lower}%"
    like_raw_nopunct = f"%{raw_nopunct}%"
    like_raw_nospace = f"%{raw_nospace}%"

    filters = [
        Offense.Name.ilike(like_raw),
        db.func.lower(Offense.Name).ilike(like_raw_lower),
        Offense.Law_Reference.ilike(like_raw),
        db.func.lower(Offense.Law_Reference).ilike(like_raw_lower),
        name_nopunct.ilike(like_raw_nospace),
        law_nopunct.ilike(like_raw_nospace),
        Offense.Name.ilike(like_raw_nopunct)
    ]

    # If the query contains digits, also try matching the digits alone (good for "8353" or "Art. 294")
    m = re.search(r'(\d+)', raw)
    if m:
        num = m.group(1)
        filters.extend([
            Offense.Name.ilike(f"%{num}%"),
            Offense.Law_Reference.ilike(f"%{num}%"),
            name_nopunct.ilike(f"%{num}%"),
            law_nopunct.ilike(f"%{num}%"),
        ])

    # Run query (OR of all filters), limit results for performance
    q = db.session.query(Offense).filter(or_(*filters)).limit(30)
    results = q.all()

    # Build JSON response (dedupe defensively)
    seen = set()
    out = []
    for o in results:
        if o.offense_id in seen:
            continue
        seen.add(o.offense_id)
        out.append({
            "id": o.offense_id,
            "text": f"{o.Name} ({o.Law_Reference or ''})"
        })

    return jsonify(out)

@admin_bp.route("/manage_crimes", methods=["GET", "POST"])
@login_required
def manage_crimes():
    form = OffenseForm()

    # Get search term from query params
    search = request.args.get("search", "", type=str).strip()

    # Base query
    query = Offense.query

    # Apply filter if search is given
    if search:
        query = query.filter(
            Offense.Name.ilike(f"%{search}%") | 
            Offense.Law_Reference.ilike(f"%{search}%")
        )

    # Pagination
    page = request.args.get("page", 1, type=int)
    per_page = 10
    crimes = query.order_by(Offense.offense_id.desc()).paginate(page=page, per_page=per_page)

    # Handle form submission
    if form.validate_on_submit():
        user_id = current_user.USER_ID  # assuming you’re using Flask-Login

        if form.add.data:
            new_offense = Offense(Name=form.name.data, Law_Reference=form.law_reference.data)
            db.session.add(new_offense)
            db.session.commit()
            log_action( f"Added new crime '{form.name.data}' ({form.law_reference.data})")
            flash("Crime added successfully!", "success")

        elif form.edit.data and form.offense_id.data:
            offense = Offense.query.get(int(form.offense_id.data))
            if offense:
                old_name = offense.Name
                old_law = offense.Law_Reference
                offense.Name = form.name.data
                offense.Law_Reference = form.law_reference.data
                db.session.commit()
                log_action(
                    f"Edited crime ID {offense.offense_id}: "
                    f"Name '{old_name}' → '{form.name.data}', "
                    f"Law Reference '{old_law}' → '{form.law_reference.data}'"
                )
                flash("Crime updated successfully!", "success")

        elif form.delete.data and form.offense_id.data:
            offense = Offense.query.get(int(form.offense_id.data))
            if offense:
                log_action(f"Deleted crime '{offense.Name}' ({offense.Law_Reference})")
                db.session.delete(offense)
                db.session.commit()
                flash("Crime deleted successfully!", "success")

        return redirect(url_for("admin.manage_crimes"))

    return render_template(
        "admin/manage_crimes.html",
        form=form,
        crimes=crimes.items,
        page=page,
        total_pages=crimes.pages,
        search=search  # pass it back to template
    )



@admin_bp.route('/archived_users')
@login_required
def archived_users():
    sort_by = request.args.get('sort', 'USER_ID')
    order = request.args.get('order', 'asc')
    search = request.args.get('search', '').strip()
    filter_by = request.args.get('filter', '')
    page = request.args.get("page", 1, type=int)
    per_page = 6 

    valid_fields = ['USER_ID', 'Full_Name', 'Role', 'Username']
    if sort_by not in valid_fields:
        sort_by = 'USER_ID'
    if order not in ['asc', 'desc']:
        order = 'asc'

    # Base query (ARCHIVED instead of ACTIVE)
    base_query = "SELECT * FROM view_manage_users WHERE Status COLLATE utf8mb4_general_ci = 'Archived'"
    conditions = []
    params = {}

    # Search filter
    if search:
        if filter_by in valid_fields:
            conditions.append(f"{filter_by} LIKE :search")
        else:
            conditions.append("(" + " OR ".join([f"{field} LIKE :search" for field in valid_fields]) + ")")
        params['search'] = f"%{search}%"

    # Apply WHERE if needed
    if conditions:
        base_query += " AND " + " AND ".join(conditions)  # Notice "AND" since we already have WHERE above

    # Apply ORDER BY
    base_query += f" ORDER BY {sort_by} {order}"

    # Count total rows
    count_sql = f"SELECT COUNT(*) as total FROM ({base_query}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    # Pagination
    base_query += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page 

    users = db.session.execute(text(base_query), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template(
        'Admin/archived_users.html',   # you can use the same template if it handles both
        users=users,
        current_sort=sort_by,
        current_order=order,
        current_search=search,
        current_filter=filter_by,
        page=page,
        total_pages=total_pages,
        view_type="archived"  # optional flag if you want to display different text/buttons
    )

@admin_bp.route('/archive-user/<int:user_id>')
@login_required
def archive_user(user_id):
    user = User.query.get_or_404(user_id)
    db.session.execute(text("UPDATE user SET Archived = 1 WHERE USER_ID = :id"), {"id": user_id})
    db.session.commit()
    log_action = f"Archived user {user.person.First_name} {user.person.Last_name}"
    db.session.execute(
        text("INSERT INTO log_table (USER_ID, Action, Timestamp) VALUES (:uid, :action, :time)"),
        {"uid": current_user.USER_ID, "action": log_action, "time": datetime.now()}
    )
    db.session.commit()
    flash(f"User {user.person.First_name} has been archived.", "info")
    return redirect(url_for('admin.manage_users'))

@admin_bp.route('/restore-user/<int:user_id>')
@login_required
def restore_user(user_id):
    user = User.query.get_or_404(user_id)
    db.session.execute(text("UPDATE user SET Archived = 0 WHERE USER_ID = :id"), {"id": user_id})
    db.session.commit()
    log_action = f"Restored user {user.person.First_name} {user.person.Last_name}"
    db.session.execute(
        text("INSERT INTO log_table (USER_ID, Action, Timestamp) VALUES (:uid, :action, :time)"),
        {"uid": current_user.USER_ID, "action": log_action, "time": datetime.now()}
    )
    db.session.commit()
    flash(f"User {user.person.First_name} has been restored.", "success")
    return redirect(url_for('admin.archived_users'))
