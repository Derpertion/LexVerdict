from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import current_user, login_required
from app.forms import SubpoenaForm, ResolutionForm
from sqlalchemy import text
from app.models import db, Subpoena, InvolvedParty, DenialComment, Offense
from app.utils import log_action
from app.services import populate_person_form, verify_subpoena_action
from app.rbac import role_required
import logging

logger = logging.getLogger(__name__)

prosecutor_bp = Blueprint('prosecutor', __name__)


@prosecutor_bp.route('/ProsecutorDashboard')
@login_required
@role_required('Prosecutor')
def dashboard():
    return render_template('prosecutor/dashboard.html')


@prosecutor_bp.route('/ProsecutorSubpoenas')
@login_required
@role_required('Prosecutor')
def subpoena_list():
    from app.services import query_paginated_view
    allowed_columns = [
        "Date_", "Verdict", "Complainant", "Respondent",
        "Crime", "Police_Station", "Prosecutor", "Docket_Number"
    ]
    rows, ctx = query_paginated_view(
        "view_subpoena_list", allowed_columns, request.args,
        extra_where="AND Prosecutor_Person_ID = :pid",
        extra_params={"pid": current_user.PERSON_ID},
    )
    return render_template("prosecutor/subpoena_list.html",
        subpoenas=rows, resolution_form=ResolutionForm(), **ctx)


@prosecutor_bp.route('/ProsecutorVerify')
@login_required
@role_required('Prosecutor')
def verify_cases():
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
    sub_total_pages = max((sub_total + sub_per_page - 1) // sub_per_page, 1)

    sub_sql += " LIMIT :limit OFFSET :offset"
    sub_params["limit"] = sub_per_page
    sub_params["offset"] = (sub_page - 1) * sub_per_page
    subpoenas = db.session.execute(text(sub_sql), sub_params).mappings().all()

    return render_template("prosecutor/verify.html",
        subpoenas=subpoenas, subpoena_form=SubpoenaForm(),
        sub_current_sort=sub_sort, sub_current_order=sub_order,
        sub_current_filter=sub_filter, sub_current_search=sub_search,
        sub_page=sub_page, sub_total_pages=sub_total_pages,
    )


@prosecutor_bp.route('/prosecutor/ProsecutorVerify/subpoena/<string:docket_number>/<string:action>', methods=['POST'])
@login_required
@role_required('Prosecutor')
def verify_subpoena(docket_number, action):
    comment = request.form.get("comment") if action == "deny" else None
    return redirect(verify_subpoena_action(
        docket_number, action, comment, url_for('prosecutor.verify_cases')
    ))


@prosecutor_bp.route('/prosecutor/verify/resolution/<string:docket_number>/<string:action>', methods=['POST'])
@login_required
@role_required('Prosecutor')
def verify_resolution(docket_number, action):
    from app.services import verify_resolution_action
    comment = request.form.get("comment", "").strip() if action == "deny" else None
    return redirect(verify_resolution_action(
        docket_number, action, comment, url_for('prosecutor.verify_cases')
    ))


@prosecutor_bp.route('/ProsecutorSubpoenas/view/<docket_number>')
@login_required
@role_required('Prosecutor')
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

    return render_template("prosecutor/view_subpoena.html", form=form)
