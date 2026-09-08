from flask import Blueprint, render_template, redirect, url_for, flash, jsonify, request, make_response, current_app
from flask_login import current_user, login_required
from app.forms import SubpoenaForm, ResolutionForm, CreateUserForm, OffenseForm
from sqlalchemy import text, func, or_
from datetime import datetime, date, timedelta
from dateutil.relativedelta import relativedelta
from app.models import db, Subpoena, Person, Address, InvolvedParty, DenialComment, User, Resolution, Username, Password, Prosecutor, Offense, SubpoenaOffense
from app.utils import log_action
from app.services import (
    populate_person_form, create_subpoena_from_form,
    compute_next_serial, update_resolution as _update_resolution,
    edit_resolution as _edit_resolution, verify_subpoena_action, verify_resolution_action,
    compute_report_data,
)
from app.rbac import role_required
from weasyprint import HTML, CSS
from collections import defaultdict
from werkzeug.security import generate_password_hash
import os, io, logging, html as html_module

logger = logging.getLogger(__name__)

admin_bp = Blueprint('admin', __name__)


@admin_bp.route('/dashboard')
@login_required
@role_required('superuser')
def dashboard():
    return render_template('Admin/dashboard.html')


@admin_bp.route('/subpoenas')
@login_required
@role_required('superuser')
def subpoena_list():
    from app.services import query_paginated_view
    allowed_columns = [
        "Date_", "Verdict", "Complainant", "Respondent",
        "Crime", "Police_Station", "Prosecutor", "Docket_Number"
    ]
    rows, ctx = query_paginated_view("view_subpoena_list", allowed_columns, request.args)
    return render_template("admin/subpoena_list.html",
        subpoenas=rows, resolution_form=ResolutionForm(), **ctx)


@admin_bp.route('/subpoenas/create', methods=['GET', 'POST'])
@login_required
@role_required('superuser')
def create_subpoena():
    form = SubpoenaForm()
    prosecutors = db.session.execute(text("SELECT PROSECUTOR_ID, full_name FROM view_prosecutor_list WHERE archived=0")).fetchall()
    form.prosecutor_id.choices = [(p.PROSECUTOR_ID, p.full_name) for p in prosecutors] if prosecutors else []

    if form.validate_on_submit():
        result = create_subpoena_from_form(form, redirect(url_for('admin.verify_cases')))
        if result is not None:
            return result
        return render_template('admin/create_subpoena.html', form=form)

    return render_template('admin/create_subpoena.html', form=form, datetime=datetime, timedelta=timedelta)


@admin_bp.route('/api/next-serial')
@login_required
def next_serial():
    from app.services import compute_next_serial
    region = request.args.get("region", "III")
    office = request.args.get("office", "09")
    type_code = request.args.get("type", "INV").upper()
    date_str = request.args.get("date")
    count = int(request.args.get("count", 1))

    result, error = compute_next_serial(region, office, type_code, date_str, count)
    if error:
        return jsonify({"error": error}), 400
    return jsonify(result)


@admin_bp.route('/verify')
@login_required
@role_required('superuser')
def verify_cases():
    sub_page = request.args.get("sub_page", 1, type=int)
    sub_per_page = 5
    sub_search = request.args.get("sub_search", "").strip()
    sub_filter = request.args.get("sub_filter", "")
    sub_sort = request.args.get("sub_sort", "Docket_Number")
    sub_order = request.args.get("sub_order", "desc")

    sub_allowed = [
        "Docket_Number", "Crimes", "Complainants", "Respondents",
        "Police_Station", "Prosecutor", "Created_By", "Date_"
    ]

    sub_sql = "SELECT * FROM view_verify_subpoenas"
    sub_params = {}
    if sub_search:
        if sub_filter in sub_allowed:
            sub_sql += f" WHERE {sub_filter} LIKE :sub_search"
        else:
            sub_sql += " WHERE Docket_Number LIKE :sub_search"
        sub_params["sub_search"] = f"%{sub_search}%"

    if sub_sort not in sub_allowed:
        sub_sort = "Docket_Number"
    sub_order_clause = "ASC" if sub_order == "asc" else "DESC"
    sub_sql += f" ORDER BY {sub_sort} {sub_order_clause}"

    sub_count_sql = f"SELECT COUNT(*) AS total FROM ({sub_sql}) AS subquery"
    sub_total = db.session.execute(text(sub_count_sql), dict(sub_params)).scalar()
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

    res_allowed = [
        "Docket_Number", "Crimes", "Complainants", "Respondents",
        "Police_Station", "Prosecutor", "Created_By",
        "Verdict", "Verdict_Date", "Court"
    ]

    res_sql = "SELECT * FROM view_verify_resolutions"
    res_params = {}
    if res_search:
        if res_filter in res_allowed:
            res_sql += f" WHERE {res_filter} LIKE :res_search"
        else:
            res_sql += " WHERE Docket_Number LIKE :res_search"
        res_params["res_search"] = f"%{res_search}%"

    if res_sort not in res_allowed:
        res_sort = "Docket_Number"
    res_order_clause = "ASC" if res_order == "asc" else "DESC"
    res_sql += f" ORDER BY {res_sort} {res_order_clause}"

    res_count_sql = f"SELECT COUNT(*) AS total FROM ({res_sql}) AS subquery"
    res_total = db.session.execute(text(res_count_sql), dict(res_params)).scalar()
    res_total_pages = max((res_total + res_per_page - 1) // res_per_page, 1)

    res_sql += " LIMIT :limit OFFSET :offset"
    res_params["limit"] = res_per_page
    res_params["offset"] = (res_page - 1) * res_per_page
    resolutions = db.session.execute(text(res_sql), res_params).mappings().all()

    return render_template("admin/verify.html",
        subpoenas=subpoenas,
        resolutions=resolutions,
        resolution_form=ResolutionForm(),
        subpoena_form=SubpoenaForm(),
        sub_current_sort=sub_sort, sub_current_order=sub_order,
        sub_current_filter=sub_filter, sub_current_search=sub_search,
        sub_page=sub_page, sub_total_pages=sub_total_pages,
        res_current_sort=res_sort, res_current_order=res_order,
        res_current_filter=res_filter, res_current_search=res_search,
        res_page=res_page, res_total_pages=res_total_pages
    )


@admin_bp.route('/admin/verify/subpoena/<string:docket_number>/<string:action>', methods=['POST'])
@login_required
@role_required('superuser')
def verify_subpoena(docket_number, action):
    comment = request.form.get("comment") if action == "deny" else None
    return redirect(verify_subpoena_action(
        docket_number, action, comment, url_for('admin.verify_cases')
    ))


@admin_bp.route('/subpoenas/edit/<docket_number>', methods=['GET', 'POST'])
@login_required
@role_required('superuser')
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
                        First_name=entry.first_name.data,
                        Middle_name=entry.middle_name.data,
                        Last_name=entry.last_name.data,
                        Suffix=entry.suffix.data,
                        Date_of_Birth=entry.birth_date.data,
                        Sex=entry.sex.data,
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
                        Street=entry.street.data,
                        Barangay=entry.barangay.data,
                        Municipality=entry.municipality.data,
                        Province=entry.province.data,
                        Region=entry.region.data,
                        PERSON_ID=person.PERSON_ID,
                    )
                    db.session.add(address)

                involved = InvolvedParty(
                    PERSON_ID=person.PERSON_ID, Docket_Number=docket_number, Role=role
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
            return redirect(url_for('admin.verify_cases'))
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

    return render_template("admin/edit_subpoena.html", form=form, denial=denial, denial_comment=denial_comment, datetime=datetime, timedelta=timedelta)


@admin_bp.route('/resolution/update', methods=['POST'])
@login_required
@role_required('superuser')
def update_resolution():
    form = ResolutionForm()
    return redirect(_update_resolution(form, redirect(url_for('admin.verify_cases'))))


@admin_bp.route("/admin/verify/resolution/<string:docket_number>/<string:action>", methods=["POST"])
@login_required
@role_required('superuser')
def verify_resolution(docket_number, action):
    comment = request.form.get("comment", "").strip() if action == "deny" else None
    return redirect(verify_resolution_action(
        docket_number, action, comment, url_for("admin.verify_cases")
    ))


@admin_bp.route("/edit_resolution", methods=["POST"])
@login_required
@role_required('superuser')
def edit_resolution():
    docket_number = request.form.get("docket_number")
    verdict = request.form.get("verdict")
    court = request.form.get("court") or None
    return redirect(_edit_resolution(docket_number, verdict, court, redirect(url_for("admin.verify_cases"))))


@admin_bp.route('/generate_subpoena_pdf/<docket_number>')
@login_required
@role_required('superuser')
def generate_subpoena_pdf(docket_number):
    subpoena = Subpoena.query.get_or_404(docket_number)
    prosecutor = subpoena.prosecutor.person if subpoena.prosecutor else None
    resolution = subpoena.resolution[0] if subpoena.resolution else None
    pin = subpoena.pin_code[0].PIN_CODE if subpoena.pin_code else None

    offenses = (
        db.session.query(Offense.Name)
        .join(SubpoenaOffense, Offense.offense_id == SubpoenaOffense.offense_id)
        .filter(SubpoenaOffense.Docket_Number == docket_number)
        .order_by(Offense.Name.asc())
        .all()
    )
    offense_names = [html_module.escape(o.Name) for o in offenses]

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

    hearing_date_1 = subpoena.Hearing_Date_1
    hearing_date_2 = subpoena.Hearing_Date_2
    issue_date = subpoena.Date_ if subpoena.Date_ else datetime.utcnow()

    staff_name = "________________"
    if hasattr(current_user, 'person') and current_user.person:
        staff_name = f"{current_user.person.First_name} {current_user.person.Last_name} {current_user.person.Suffix or ''}"

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
@role_required('superuser')
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

    return render_template("admin/view_subpoena.html", form=form)


@admin_bp.route('/reports', methods=['GET', 'POST'])
@login_required
@role_required('superuser')
def reports():
    has_filters = any(request.args.values())
    data = compute_report_data(request.args.get, request.args.getlist)

    all_crimes = [o.Name for o in Offense.query.order_by(Offense.Name).all()]

    return render_template(
        'Admin/reports.html',
        total_cases=data['total_cases'], filed=data['filed'], dismissed=data['dismissed'],
        most_common_crime=data['most_common_crime'], top_case_selected=data['top_case_selected'],
        bar_chart_data=data['bar_chart_data'], verdict_data=data['verdict_data'],
        sex_data=data['sex_data'], age_data=data['age_data'],
        station_data=data['station_data'][:5],
        filters=request.args, has_filters=has_filters, all_crimes=all_crimes
    )


@admin_bp.route('/reports/pdf', methods=['POST'])
@login_required
@role_required('superuser')
def reports_pdf():
    import json
    data = compute_report_data(request.form.get, request.form.getlist)

    charts_json = request.form.get('charts')
    chart_images = []
    try:
        charts = json.loads(charts_json) if charts_json else []
        for c in charts:
            if isinstance(c, dict) and isinstance(c.get('image'), str) and c['image'].startswith('data:image'):
                chart_images.append({'name': str(c.get('name') or 'Chart'), 'image': c['image']})
            elif isinstance(c, str) and c.startswith('data:image'):
                chart_images.append({'name': 'Chart', 'image': c})
    except Exception:
        chart_images = []

    start_date = data['start_date']
    end_date = data['end_date']
    verdict = data['verdict']
    station = data['station']
    sex = data['sex']
    age_group = data['age_group']
    final_names = data['final_names']

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

    rendered = render_template(
        'Admin/reports_print.html',
        total_cases=data['total_cases'], filed=data['filed'], dismissed=data['dismissed'],
        most_common_crime=data['most_common_crime'], bar_chart_data=data['bar_chart_data'],
        verdict_data=data['verdict_data'], sex_data=data['sex_data'], age_data=data['age_data'],
        station_data=data['station_data'],
        generated_text=generated_text, chart_images=chart_images,
        show_crime_sections=not bool(final_names), hide_sex=bool(sex),
        hide_age=bool(age_group), hide_station=bool(station),
    )

    css = CSS(string='''
        @page { size: A4 landscape; margin: 12mm; }
        body { font-family: "Segoe UI", Arial, sans-serif; font-size: 11px; color: #222; }
        h1,h2 { color:#2a1d76; margin:0 0 6px 0; }
        .row { display: table; width:100%; table-layout: fixed; }
        .col { display: table-cell; vertical-align: top; padding:8px; }
        .left { width:260px; }
        .center { width: calc(100% - 260px - 360px); }
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
@role_required('superuser')
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

    base_query = "SELECT * FROM view_manage_users WHERE Status COLLATE utf8mb4_general_ci = 'Active'"
    conditions = []
    params = {}

    if search:
        if filter_by in valid_fields:
            conditions.append(f"{filter_by} LIKE :search")
        else:
            conditions.append("(" + " OR ".join([f"{field} LIKE :search" for field in valid_fields]) + ")")
        params['search'] = f"%{search}%"

    if conditions:
        base_query += " AND " + " AND ".join(conditions)

    base_query += f" ORDER BY {sort_by} {order}"

    count_sql = f"SELECT COUNT(*) as total FROM ({base_query}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    base_query += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page

    users = db.session.execute(text(base_query), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template('Admin/manage_user.html',
        users=users, current_sort=sort_by, current_order=order,
        current_search=search, current_filter=filter_by,
        page=page, total_pages=total_pages)


@admin_bp.route('/create_user', methods=['GET', 'POST'])
@login_required
@role_required('superuser')
def create_user():
    form = CreateUserForm()

    if form.validate_on_submit():
        existing_username = Username.query.filter_by(Username=form.username.data).first()
        if existing_username:
            flash('Username already exists. Please choose another.', 'danger')
            return render_template('admin/create_user.html', form=form)

        person = Person(
            First_name=form.first_name.data, Last_name=form.last_name.data,
            Middle_name=form.middle_name.data, Suffix=form.suffix.data,
            Date_of_Birth=form.birth_date.data, Sex=form.sex.data,
        )
        db.session.add(person)
        db.session.flush()

        address = Address(
            PERSON_ID=person.PERSON_ID, Street=form.street.data,
            Barangay=form.barangay.data, Municipality=form.municipality.data,
            Province=form.province.data, Region=form.region.data,
        )
        db.session.add(address)

        user = User(PERSON_ID=person.PERSON_ID, Role=form.role.data)
        db.session.add(user)
        db.session.flush()

        username = Username(USER_ID=user.USER_ID, Username=form.username.data)
        db.session.add(username)

        password = Password(USER_ID=user.USER_ID, Password=generate_password_hash(form.password.data))
        db.session.add(password)

        if form.role.data == 'Prosecutor':
            prosecutor = Prosecutor(PERSON_ID=person.PERSON_ID, Licens_No=form.license_no.data, Office_No=form.office_no.data)
            db.session.add(prosecutor)

        db.session.commit()

        full_name = f"{person.First_name} {person.Middle_name or ''} {person.Last_name} {person.Suffix or ''}".strip()
        log_action(f"Created new user: {full_name} with role '{user.Role}' and username '{username.Username}'")
        flash('User successfully created!', 'success')
        return redirect(url_for('admin.manage_users'))

    return render_template('admin/create_user.html', form=form)


@admin_bp.route('/edit_user/<int:user_id>', methods=['GET', 'POST'])
@login_required
@role_required('superuser')
def edit_user(user_id):
    user = User.query.get_or_404(user_id)
    person = user.person
    username_obj = user.username[0] if user.username else None
    password_obj = user.password[0] if user.password else None
    address = person.address[0] if person.address else None
    prosecutor = Prosecutor.query.filter_by(PERSON_ID=person.PERSON_ID).first()

    form = CreateUserForm()

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
        if user.Role == 'Prosecutor' and prosecutor:
            form.license_no.data = prosecutor.Licens_No
            form.office_no.data = prosecutor.Office_No

    if form.validate_on_submit():
        existing_username = Username.query.filter(
            Username.Username == form.username.data, Username.USER_ID != user.USER_ID
        ).first()
        if existing_username:
            flash('Username already exists. Please choose another.', 'danger')
            return render_template('admin/edit_user.html', form=form)

        changes = []

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
                PERSON_ID=person.PERSON_ID, Street=form.street.data,
                Barangay=form.barangay.data, Municipality=form.municipality.data,
                Province=form.province.data, Region=form.region.data,
            )
            db.session.add(new_address)
            changes.append("Added new address")

        if user.Role != form.role.data:
            changes.append(f"Role from '{user.Role}' to '{form.role.data}'")
            user.Role = form.role.data

        if username_obj:
            if username_obj.Username != form.username.data:
                changes.append(f"Username from '{username_obj.Username}' to '{form.username.data}'")
                username_obj.Username = form.username.data
        else:
            new_username = Username(USER_ID=user.USER_ID, Username=form.username.data)
            db.session.add(new_username)
            changes.append("Added new username")

        if form.password.data:
            new_pw_hash = generate_password_hash(form.password.data)
            if password_obj:
                password_obj.Password = new_pw_hash
                changes.append("Updated password")
            else:
                db.session.add(Password(USER_ID=user.USER_ID, Password=new_pw_hash))
                changes.append("Added new password")

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
                    PERSON_ID=person.PERSON_ID, Licens_No=form.license_no.data, Office_No=form.office_no.data
                )
                db.session.add(new_prosecutor)
                changes.append("Added new prosecutor info")
        elif prosecutor:
            db.session.delete(prosecutor)
            changes.append("Removed prosecutor info (role changed)")

        db.session.commit()

        if changes:
            full_name = f"{person.First_name} {person.Middle_name or ''} {person.Last_name} {person.Suffix or ''}".strip()
            log_action(f"Edited user '{full_name}': " + "; ".join(changes))

        flash('User updated successfully!', 'success')
        return redirect(url_for('admin.manage_users'))

    return render_template('admin/edit_user.html', form=form)


@admin_bp.route('/delete_user/<int:user_id>', methods=['POST'])
@login_required
@role_required('superuser')
def delete_user(user_id):
    user = User.query.get_or_404(user_id)
    full_name = "Unknown"
    username = "Unknown"
    role = user.Role

    if user.person:
        full_name = f"{user.person.First_name} {user.person.Middle_name or ''} {user.person.Last_name} {user.person.Suffix or ''}".strip()
    if user.username:
        username = user.username[0].Username

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
@role_required('superuser')
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

    count_sql = f"SELECT COUNT(*) as total FROM ({final_query}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    final_query += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page

    log = db.session.execute(text(final_query), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template('admin/user_logs.html',
        log=log, current_search=search, current_filter=filter_column,
        current_sort=sort_column, current_order=sort_order,
        page=page, total_pages=total_pages)


@admin_bp.route('/search_offense')
@login_required
def search_offense():
    import re
    raw = request.args.get('q', '').strip()
    if not raw:
        return jsonify([])

    raw_lower = raw.lower()
    raw_nopunct = re.sub(r'[^\w\s]', '', raw_lower)
    raw_nospace = re.sub(r'\s+', '', raw_nopunct)

    name_lower = db.func.lower(Offense.Name)
    name_nopunct = db.func.replace(db.func.replace(db.func.replace(name_lower, '.', ''), ' ', ''), '-', '')
    law_lower = db.func.lower(Offense.Law_Reference)
    law_nopunct = db.func.replace(db.func.replace(db.func.replace(law_lower, '.', ''), ' ', ''), '-', '')

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

    m = re.search(r'(\d+)', raw)
    if m:
        num = m.group(1)
        filters.extend([
            Offense.Name.ilike(f"%{num}%"),
            Offense.Law_Reference.ilike(f"%{num}%"),
            name_nopunct.ilike(f"%{num}%"),
            law_nopunct.ilike(f"%{num}%"),
        ])

    q = db.session.query(Offense).filter(or_(*filters)).limit(30)
    results = q.all()

    seen = set()
    out = []
    for o in results:
        if o.offense_id in seen:
            continue
        seen.add(o.offense_id)
        out.append({"id": o.offense_id, "text": f"{o.Name} ({o.Law_Reference or ''})"})

    return jsonify(out)


@admin_bp.route("/manage_crimes", methods=["GET", "POST"])
@login_required
@role_required('superuser')
def manage_crimes():
    form = OffenseForm()
    search = request.args.get("search", "", type=str).strip()

    query = Offense.query
    if search:
        query = query.filter(Offense.Name.ilike(f"%{search}%") | Offense.Law_Reference.ilike(f"%{search}%"))

    page = request.args.get("page", 1, type=int)
    per_page = 10
    crimes = query.order_by(Offense.offense_id.desc()).paginate(page=page, per_page=per_page)

    if form.validate_on_submit():
        if form.add.data:
            new_offense = Offense(Name=form.name.data, Law_Reference=form.law_reference.data)
            db.session.add(new_offense)
            db.session.commit()
            log_action(f"Added new crime '{form.name.data}' ({form.law_reference.data})")
            flash("Crime added successfully!", "success")
        elif form.edit.data and form.offense_id.data:
            offense = Offense.query.get(int(form.offense_id.data))
            if offense:
                old_name = offense.Name
                old_law = offense.Law_Reference
                offense.Name = form.name.data
                offense.Law_Reference = form.law_reference.data
                db.session.commit()
                log_action(f"Edited crime ID {offense.offense_id}: Name '{old_name}' -> '{form.name.data}', Law Reference '{old_law}' -> '{form.law_reference.data}'")
                flash("Crime updated successfully!", "success")
        elif form.delete.data and form.offense_id.data:
            offense = Offense.query.get(int(form.offense_id.data))
            if offense:
                log_action(f"Deleted crime '{offense.Name}' ({offense.Law_Reference})")
                db.session.delete(offense)
                db.session.commit()
                flash("Crime deleted successfully!", "success")
        return redirect(url_for("admin.manage_crimes"))

    return render_template("admin/manage_crimes.html",
        form=form, crimes=crimes.items, page=page, total_pages=crimes.pages, search=search)


@admin_bp.route('/archived_users')
@login_required
@role_required('superuser')
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

    base_query = "SELECT * FROM view_manage_users WHERE Status COLLATE utf8mb4_general_ci = 'Archived'"
    conditions = []
    params = {}

    if search:
        if filter_by in valid_fields:
            conditions.append(f"{filter_by} LIKE :search")
        else:
            conditions.append("(" + " OR ".join([f"{field} LIKE :search" for field in valid_fields]) + ")")
        params['search'] = f"%{search}%"

    if conditions:
        base_query += " AND " + " AND ".join(conditions)

    base_query += f" ORDER BY {sort_by} {order}"

    count_sql = f"SELECT COUNT(*) as total FROM ({base_query}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    base_query += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page

    users = db.session.execute(text(base_query), params).mappings().all()
    total_pages = (total + per_page - 1) // per_page

    return render_template('Admin/archived_users.html',
        users=users, current_sort=sort_by, current_order=order,
        current_search=search, current_filter=filter_by,
        page=page, total_pages=total_pages, view_type="archived")


@admin_bp.route('/archive-user/<int:user_id>', methods=['POST'])
@login_required
@role_required('superuser')
def archive_user(user_id):
    user = User.query.get_or_404(user_id)
    db.session.execute(text("UPDATE user SET Archived = 1 WHERE USER_ID = :id"), {"id": user_id})
    db.session.commit()
    log_action(f"Archived user {user.person.First_name} {user.person.Last_name}", user_id=current_user.USER_ID)
    flash(f"User {user.person.First_name} has been archived.", "info")
    return redirect(url_for('admin.manage_users'))


@admin_bp.route('/restore-user/<int:user_id>', methods=['POST'])
@login_required
@role_required('superuser')
def restore_user(user_id):
    user = User.query.get_or_404(user_id)
    db.session.execute(text("UPDATE user SET Archived = 0 WHERE USER_ID = :id"), {"id": user_id})
    db.session.commit()
    log_action(f"Restored user {user.person.First_name} {user.person.Last_name}", user_id=current_user.USER_ID)
    flash(f"User {user.person.First_name} has been restored.", "success")
    return redirect(url_for('admin.archived_users'))
