from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import current_user, login_required
from app.forms import SubpoenaForm
from sqlalchemy import text
from app.models import db, Subpoena, Person, Address, InvolvedParty, DenialComment, DenialComment, Offense
from app.forms import SubpoenaForm, ResolutionForm
from app.utils import log_action
import random, string

prosecutor_bp = Blueprint('prosecutor', __name__)

def generate_pin(length=6):
    return ''.join(random.choices(string.digits, k=length))

@prosecutor_bp.route('/ProsectutorDashboard')
@login_required
def dashboard():
    return render_template('prosecutor/dashboard.html')

@prosecutor_bp.route('/ProsecutorSubpoenas')
@login_required
def subpoena_list():
    search_value = request.args.get("search", "").strip()
    search_column = request.args.get("filter", "")  # e.g. 'Docket_Number', 'Crime', etc.
    sort_by = request.args.get("sort", "Docket_Number")     # e.g. 'Date_', 'Verdict'
    sort_order = request.args.get("order", "desc")  # 'asc' or 'desc'
    page = request.args.get("page", 1, type=int)
    per_page = 6 

    allowed_columns = [
        "Date_", "Verdict", "Complainant", "Respondent",
        "Crime", "Police_Station", "Prosecutor", "Docket_Number"
    ]

    sql = "SELECT * FROM view_subpoena_list WHERE Prosecutor_Person_ID = :pid"
    params = {"pid": current_user.PERSON_ID}

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
        sort_by = "Docket_Number"
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

    return render_template("prosecutor/subpoena_list.html",
        subpoenas=subpoenas,
        resolution_form=ResolutionForm(),
        current_sort=sort_by,
        current_order=sort_order,
        current_filter=search_column,
        current_search=search_value,
        page=page,
        total_pages=total_pages
    )

@prosecutor_bp.route('/ProsecutorVerify')
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

    sub_sql = "SELECT * FROM view_verify_subpoenas WHERE Prosecutor_Person_ID = :pid"
    sub_params = {"pid": current_user.PERSON_ID}

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
    # RENDER TEMPLATE
    # =============================
    return render_template("prosecutor/verify.html",
        subpoenas=subpoenas,
        subpoena_form=SubpoenaForm(),

        # Subpoena params
        sub_current_sort=sub_sort,
        sub_current_order=sub_order,
        sub_current_filter=sub_filter,
        sub_current_search=sub_search,
        sub_page=sub_page,
        sub_total_pages=sub_total_pages,
    )


@prosecutor_bp.route('/prosecutor/ProsecutorVerify/subpoena/<string:docket_number>/<string:action>', methods=['GET', 'POST'])
@login_required
def verify_subpoena(docket_number, action):
    subpoena = Subpoena.query.get(docket_number)

    if not subpoena:
        flash("Subpoena not found.", "danger")
        return redirect(url_for('prosecutor.verify_cases'))

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
            return redirect(url_for('prosecutor.verify_cases'))

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

    return redirect(url_for('prosecutor.verify_cases'))

@prosecutor_bp.route('/ProsectortSubpoenas/view/<docket_number>')
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

    return render_template("prosecutor/view_subpoena.html", form=form)

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
            .order_by(Address.Address_ID.desc())  # Or filter further if you log Address per Subpoena
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
        entry.birth_date.data = person.Date_of_Birth
        entry.sex.data = person.Sex
        entry.street.data = address.Street
        entry.barangay.data = address.Barangay
        entry.municipality.data = address.Municipality
        entry.province.data = address.Province
        entry.region.data = address.Region