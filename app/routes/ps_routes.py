from flask import Blueprint, render_template, request
from flask_login import login_required
from app.services import query_paginated_view
from app.forms import ResolutionForm
from app.rbac import role_required

ps_bp = Blueprint('process_server', __name__)


@ps_bp.route('/PSDashboard')
@login_required
@role_required('PS')
def dashboard():
    return render_template('process_server/dashboard.html')


@ps_bp.route('/PSSubpoenas')
@login_required
@role_required('PS')
def subpoena_list():
    allowed_columns = [
        "Date_", "Verdict", "Complainant", "Respondent",
        "Crime", "Police_Station", "Prosecutor", "Docket_Number", "Verdict_Date"
    ]
    rows, ctx = query_paginated_view("view_subpoena_list", allowed_columns, request.args)
    return render_template("process_server/subpoena_list.html",
        subpoenas=rows, resolution_form=ResolutionForm(), **ctx)
