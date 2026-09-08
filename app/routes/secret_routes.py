from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import current_user, login_required
from app.forms import SubpoenaForm, ResolutionForm
from sqlalchemy import text, func
from datetime import datetime, date, timedelta
from app.models import db, Subpoena, Person, Address, InvolvedParty, DenialComment, Offense, SubpoenaOffense
from app.utils import log_action
from app.services import (
    populate_person_form, create_subpoena_from_form,
    update_resolution as _update_resolution,
    edit_resolution as _edit_resolution,
)
from app.rbac import role_required
import logging

logger = logging.getLogger(__name__)

secret_bp = Blueprint('secretary', __name__)


@secret_bp.route('/SecretDashboard')
@login_required
@role_required('Secretary')
def dashboard():
    return render_template('Secretary/dashboard.html')


@secret_bp.route('/YourSubpoenas')
@login_required
@role_required('Secretary')
def subpoena_list():
    from app.services import query_paginated_view
    allowed_columns = [
        "Date_", "Verdict", "Complainant", "Respondent",
        "Crime", "Police_Station", "Prosecutor", "Docket_Number"
    ]
    rows, ctx = query_paginated_view(
        "view_subpoena_list", allowed_columns, request.args,
        extra_where="AND Creator_ID = :user_id",
        extra_params={"user_id": current_user.USER_ID},
    )
    return render_template("Secretary/subpoena_list.html",
        subpoenas=rows, resolution_form=ResolutionForm(), **ctx)


@secret_bp.route('/YourSubpoenas/create', methods=['GET', 'POST'])
@login_required
@role_required('Secretary')
def create_subpoena():
    form = SubpoenaForm()
    prosecutors = db.session.execute(text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list WHERE archived=0")).fetchall()
    form.prosecutor_id.choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors] if prosecutors else []

    if form.validate_on_submit():
        result = create_subpoena_from_form(form, redirect(url_for('secretary.verify_cases')))
        if result is not None:
            return result
        return render_template('secretary/create_subpoena.html', form=form)

    return render_template('secretary/create_subpoena.html', form=form, datetime=datetime, timedelta=timedelta)


@secret_bp.route('/YourVerify')
@login_required
@role_required('Secretary')
def verify_cases():
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
    sub_total_pages = max((sub_total + sub_per_page - 1) // sub_per_page, 1)

    sub_sql += " LIMIT :limit OFFSET :offset"
    sub_params["limit"] = sub_per_page
    sub_params["offset"] = (sub_page - 1) * sub_per_page
    subpoenas = db.session.execute(text(sub_sql), sub_params).mappings().all()

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
    res_total_pages = max((res_total + res_per_page - 1) // res_per_page, 1)

    res_sql += " LIMIT :limit OFFSET :offset"
    res_params["limit"] = res_per_page
    res_params["offset"] = (res_page - 1) * res_per_page
    resolutions = db.session.execute(text(res_sql), res_params).mappings().all()

    return render_template("secretary/verify.html",
        subpoenas=subpoenas, resolutions=resolutions,
        resolution_form=ResolutionForm(), subpoena_form=SubpoenaForm(),
        sub_current_sort=sub_sort, sub_current_order=sub_order,
        sub_current_filter=sub_filter, sub_current_search=sub_search,
        sub_page=sub_page, sub_total_pages=sub_total_pages,
        res_current_sort=res_sort, res_current_order=res_order,
        res_current_filter=res_filter, res_current_search=res_search,
        res_page=res_page, res_total_pages=res_total_pages
    )


@secret_bp.route('/YourSubpoenas/edit/<docket_number>', methods=['GET', 'POST'])
@login_required
@role_required('Secretary')
def edit_subpoena(docket_number):
    form = SubpoenaForm()
    subpoena = Subpoena.query.get_or_404(docket_number)
    denial = DenialComment.query.filter_by(Docket_Number=docket_number).first()
    denial_comment = denial.Comment if denial else None

    prosecutors = db.session.execute(
        db.text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list")
    ).fetchall()
    prosecutor_choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors]
    form.prosecutor_id.choices = [(-1, 'Select Prosecutor')] + prosecutor_choices

    offenses = Offense.query.all()
    form.crimes.choices = [(int(o.offense_id), o.Name) for o in offenses]

    if request.method == 'POST':
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
            old_offenses = {so.offense_id for so in subpoena.offenses}
            new_offenses = set(map(int, form.crimes.data)) if form.crimes.data else set()
            if old_offenses != new_offenses:
                old_names = [o.Name for o in Offense.query.filter(Offense.offense_id.in_(old_offenses))]
                new_names = [o.Name for o in Offense.query.filter(Offense.offense_id.in_(new_offenses))]
                changes.append(f"Crimes from {old_names} to {new_names}")

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

            subpoena.Date_ = form.date.data
            subpoena.Hearing_Date_1 = form.hearing_date_1.data
            subpoena.Hearing_Date_2 = form.hearing_date_2.data
            subpoena.Police_Station = form.police_station.data
            subpoena.PROSECUTOR_ID = form.prosecutor_id.data
            subpoena.Status = 'Pending'

            if old_offenses != new_offenses:
                db.session.query(SubpoenaOffense).filter_by(Docket_Number=docket_number).delete()
                for offense_id in new_offenses:
                    db.session.add(SubpoenaOffense(Docket_Number=docket_number, offense_id=offense_id))

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
                    Person.Sex == entry.sex.data,
                ).first()
                new_created = False
                if not person:
                    person = Person(
                        First_name=entry.first_name.data, Middle_name=entry.middle_name.data,
                        Last_name=entry.last_name.data, Suffix=entry.suffix.data,
                        Date_of_Birth=entry.birth_date.data, Sex=entry.sex.data,
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
                    func.lower(Address.Region) == entry.region.data.lower(),
                ).first()
                if not address:
                    address = Address(
                        Street=entry.street.data, Barangay=entry.barangay.data,
                        Municipality=entry.municipality.data, Province=entry.province.data,
                        Region=entry.region.data, PERSON_ID=person.PERSON_ID,
                    )
                    db.session.add(address)

                involved = InvolvedParty(PERSON_ID=person.PERSON_ID, Docket_Number=docket_number, Role=role)
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
            return redirect(url_for('secretary.verify_cases'))
        else:
            flash("Validation failed. Please check your inputs.", "danger")
    else:
        form.docket_number.data = subpoena.Docket_Number
        form.crimes.data = [int(so.offense_id) for so in subpoena.offenses]
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


@secret_bp.route('/secretary/verify/subpoena/<string:docket_number>/<string:action>', methods=['POST'])
@login_required
@role_required('Secretary')
def verify_subpoena(docket_number, action):
    from app.services import verify_subpoena_action
    comment = request.form.get("comment") if action == "deny" else None
    return redirect(verify_subpoena_action(
        docket_number, action, comment, url_for('secretary.verify_cases')
    ))


@secret_bp.route('/YourSubpoenas/view/<docket_number>')
@login_required
@role_required('Secretary')
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

    populate_person_form(form.complainants, 'Complainant', docket_number)
    populate_person_form(form.respondents, 'Respondent', docket_number)

    return render_template("secretary/view_subpoena.html", form=form)


@secret_bp.route('/YourResolution/update', methods=['POST'])
@login_required
@role_required('Secretary')
def update_resolution():
    form = ResolutionForm()
    return redirect(_update_resolution(form, redirect(url_for('secretary.verify_cases'))))


@secret_bp.route("/edit_YourResolution", methods=["POST"])
@login_required
@role_required('Secretary')
def edit_resolution():
    docket_number = request.form.get("docket_number")
    verdict = request.form.get("verdict")
    court = request.form.get("court") or None
    return redirect(_edit_resolution(docket_number, verdict, court, redirect(url_for("secretary.verify_cases"))))
