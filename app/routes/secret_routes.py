from flask import Blueprint, render_template, request, redirect, url_for, flash, jsonify
from flask_login import current_user, login_required
from app.forms import SubpoenaForm
from sqlalchemy import text, func
from sqlalchemy.exc import IntegrityError
from datetime import datetime, date, timedelta
from dateutil.relativedelta import relativedelta
from app.models import db, Subpoena, Person, Address, InvolvedParty, DenialComment, PinCode, LogTable, Resolution, DenialComment, Offense, SubpoenaOffense
from app.forms import SubpoenaForm, ResolutionForm
from datetime import datetime
from app.utils import log_action
import random, string

secret_bp = Blueprint('secretary', __name__)

def generate_pin(length=6):
    return ''.join(random.choices(string.digits, k=length))

@secret_bp.route('/SecretDashboard')
@login_required
def dashboard():
    return render_template('Secretary/dashboard.html')

@secret_bp.route('/YourSubpoenas')
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

    sql = "SELECT * FROM view_subpoena_list WHERE 1=1 AND Creator_ID = :user_id "
    params = {"user_id": current_user.USER_ID}

    # If search is provided...
    if search_value:
        if search_column and search_column in allowed_columns:
            # Specific field
            sql += f" AND {search_column} LIKE :search_value"
            params["search_value"] = f"%{search_value}%"
        elif not search_column:  # All fields
            # Broad search (basic OR across likely fields)
            sql += """
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

    # Sorting
    if sort_by not in allowed_columns:
        sort_by = "Docket Number"
    order_clause = "ASC" if sort_order == "asc" else "DESC"
    sql += f" ORDER BY {sort_by} {order_clause}"

    # Count total rows first
    count_sql = f"SELECT COUNT(*) as total FROM ({sql}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    # Apply pagination
    sql += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page

    subpoenas = db.session.execute(text(sql), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template("Secretary/subpoena_list.html", 
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

@secret_bp.route('/YourSubpoenas/create', methods=['GET', 'POST'])
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
                    return render_template('secretary/create_subpoena.html', form=form)

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
            return render_template('secretary/create_subpoena.html', form=form)

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
                return redirect(url_for('secretary.verify_cases'))

            except IntegrityError as ie:
                # Some unique constraint (likely Docket_Number) collided. Rollback and retry.
                db.session.rollback()
                last_err = ie
                # If max attempts reached, abort with an error message
                if attempt >= MAX_RESERVE_ATTEMPTS:
                    flash("Could not reserve docket number due to concurrent submissions. Please try again.", "danger")
                    return render_template('secretary/create_subpoena.html', form=form)
                # otherwise, loop to try reserve new serials
                continue

            except Exception as e:
                db.session.rollback()
                # Unexpected error - show a message and log if you have a logger
                flash("An unexpected error occurred while creating subpoena.", "danger")
                # Optionally log e
                return render_template('secretary/create_subpoena.html', form=form)

        # If we fell out of loop with last_err:
        flash("Failed to create subpoena. Please retry.", "danger")
        return render_template('secretary/create_subpoena.html', form=form)

    # Default render
    return render_template('secretary/create_subpoena.html', form=form, datetime=datetime, timedelta=timedelta)

@secret_bp.route('/api/next-serial')
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


@secret_bp.route('/YourVerify')
@login_required
def verify_cases():
    # ============================
    # SUBPOENA PARAMS (current user)
    # ============================
    sub_page = request.args.get("sub_page", 1, type=int)
    sub_per_page = 5
    sub_search = request.args.get("sub_search", "").strip()
    sub_filter = request.args.get("sub_filter", "")
    sub_sort = request.args.get("sub_sort", "Docket_Number")
    sub_order = request.args.get("sub_order", "desc")

    sub_allowed = ["Docket_Number", "Crime", "Complainants", "Respondents",
                   "Police_Station", "Prosecutor", "Created_By", "Date_"]

    sub_sql = "SELECT * FROM view_verify_subpoenas WHERE Creator_ID = :user_id"
    sub_params = {"user_id": current_user.USER_ID}

    if sub_search:
        if sub_filter in sub_allowed:
            sub_sql += f" AND {sub_filter} LIKE :sub_search"
        else:
            sub_sql += " AND Docket_Number LIKE :sub_search"
        sub_params["sub_search"] = f"%{sub_search}%"

    if sub_sort not in sub_allowed:
        sub_sort = "Docket_Number"
    sub_order_clause = "ASC" if sub_order == "asc" else "DESC"
    sub_sql += f" ORDER BY {sub_sort} {sub_order_clause}"

    sub_count_sql = f"SELECT COUNT(*) AS total FROM ({sub_sql}) AS subquery"
    sub_total = db.session.execute(text(sub_count_sql), sub_params).scalar()

    sub_sql += " LIMIT :limit OFFSET :offset"
    sub_params["limit"] = sub_per_page
    sub_params["offset"] = (sub_page - 1) * sub_per_page
    subpoenas = db.session.execute(text(sub_sql), sub_params).mappings().all()
    sub_total_pages = (sub_total + sub_per_page - 1) // sub_per_page

    # =============================
    # RESOLUTION PARAMS (current user)
    # =============================
    res_page = request.args.get("res_page", 1, type=int)
    res_per_page = 5
    res_search = request.args.get("res_search", "").strip()
    res_filter = request.args.get("res_filter", "")
    res_sort = request.args.get("res_sort", "Docket_Number")
    res_order = request.args.get("res_order", "desc")

    res_allowed = ["Docket_Number", "Crime", "Complainants", "Respondents",
                   "Police_Station", "Prosecutor", "Created_By",
                   "Verdict", "Verdict_Date", "Court"]

    res_sql = "SELECT * FROM view_verify_resolutions WHERE Creator_ID = :user_id"
    res_params = {"user_id": current_user.USER_ID}

    if res_search:
        if res_filter in res_allowed:
            res_sql += f" AND {res_filter} LIKE :res_search"
        else:
            res_sql += " AND Docket_Number LIKE :res_search"
        res_params["res_search"] = f"%{res_search}%"

    if res_sort not in res_allowed:
        res_sort = "Docket_Number"
    res_order_clause = "ASC" if res_order == "asc" else "DESC"
    res_sql += f" ORDER BY {res_sort} {res_order_clause}"

    res_count_sql = f"SELECT COUNT(*) AS total FROM ({res_sql}) AS subquery"
    res_total = db.session.execute(text(res_count_sql), res_params).scalar()

    res_sql += " LIMIT :limit OFFSET :offset"
    res_params["limit"] = res_per_page
    res_params["offset"] = (res_page - 1) * res_per_page
    resolutions = db.session.execute(text(res_sql), res_params).mappings().all()
    res_total_pages = (res_total + res_per_page - 1) // res_per_page

    # =============================
    # RENDER TEMPLATE
    # =============================
    return render_template("secretary/verify.html",
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


@secret_bp.route('/YourSubpoenas/edit/<docket_number>', methods=['GET', 'POST'])
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
            return redirect(url_for('secretary.verify_cases', docket_number=docket_number, action='recheck'))
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

    return render_template("secretary/edit_subpoena.html", form=form, denial=denial, denial_comment=denial_comment)



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

@secret_bp.route('/YourSubpoenas/view/<docket_number>')
@login_required
def view_subpoena(docket_number):
    form = SubpoenaForm()
    subpoena = Subpoena.query.get_or_404(docket_number)

    prosecutors = db.session.execute(
        db.text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list")
    ).fetchall()
    form.prosecutor_id.choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors]

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

    return render_template("secretary/view_subpoena.html", form=form)

@secret_bp.route('/YourResolution/update', methods=['POST'])
@login_required
def update_resolution():
    form = ResolutionForm()

    if form.validate_on_submit():
        docket_number = form.docket_number.data
        verdict = form.verdict.data

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
        return redirect(url_for('secretary.verify_cases'))

    flash('Failed to submit resolution. Please check inputs.', 'danger')
    return redirect(url_for('secretary.verify_cases'))

@secret_bp.route("/edit_YourResolution", methods=["POST"])
@login_required
def edit_resolution():  
    form = ResolutionForm()
    form.verdict.choices = [('For Filing', 'For Filing'), ('Dismissed', 'Dismissed')]

    docket_number = request.form.get("docket_number")
    verdict = request.form.get("verdict")
    court = request.form.get("court") or None

    if verdict not in ['For Filing', 'Dismissed']:
        flash("Invalid verdict selection for editing.", "danger")
        return redirect(url_for("secretary.verify_cases"))

    verdict_date = datetime.utcnow().date()
    resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()

    if not resolution:
        flash("Resolution not found.", "error")
        return redirect(url_for("secretary.verify_cases"))

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
    return redirect(url_for("secretary.verify_cases"))

