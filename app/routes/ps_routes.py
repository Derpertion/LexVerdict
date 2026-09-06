from flask import Blueprint, render_template, request
from flask_login import login_required
from sqlalchemy import text
from app.models import db
from app.forms import ResolutionForm

ps_bp = Blueprint('process_server', __name__)

@ps_bp.route('/PSDashboard')
@login_required
def dashboard():
    return render_template('process_server/dashboard.html')

@ps_bp.route('/PSSubpoenas')
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
        "Crime", "Police_Station", "Prosecutor", "Docket_Number", "Verdict_Date"
    ]

    sql = "SELECT * FROM view_subpoena_list WHERE 1=1"
    params = {}

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

    return render_template("process_server/subpoena_list.html",
        subpoenas=subpoenas,
        resolution_form=ResolutionForm(),
        current_sort=sort_by,
        current_order=sort_order,
        current_filter=search_column,
        current_search=search_value,
        page=page,
        total_pages=total_pages
    )