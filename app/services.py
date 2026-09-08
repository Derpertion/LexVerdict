import random
import string
import logging
from datetime import datetime, date

from flask import flash
from flask_login import current_user
from sqlalchemy import text, func
from sqlalchemy.exc import IntegrityError

from app.models import (
    db, Subpoena, Person, Address, InvolvedParty, PinCode,
    LogTable, Resolution, DenialComment, Offense, SubpoenaOffense,
)

logger = logging.getLogger(__name__)

MAX_RESERVE_ATTEMPTS = 5


def generate_pin(length=6):
    return ''.join(random.choices(string.digits, k=length))


# ---------------------------------------------------------------------------
# Person / Address helpers
# ---------------------------------------------------------------------------

def norm_str(s):
    return "" if s is None else s.strip()


def norm_for_compare(s):
    return norm_str(s).lower()


def get_or_create_person(first, middle, last, suffix, birth, sex):
    """Find or create a Person record, comparing case-insensitively."""
    f = norm_for_compare(first)
    m = norm_for_compare(middle)
    l = norm_for_compare(last)
    sfx = norm_for_compare(suffix)

    person = db.session.query(Person).filter(
        func.lower(Person.First_name) == f,
        func.lower(Person.Middle_name) == m,
        func.lower(Person.Last_name) == l,
        func.coalesce(func.lower(Person.Suffix), '') == sfx,
        Person.Date_of_Birth == birth,
        Person.Sex == sex,
    ).first()

    if not person:
        person = Person(
            First_name=norm_str(first),
            Middle_name=norm_str(middle),
            Last_name=norm_str(last),
            Suffix=norm_str(suffix),
            Date_of_Birth=birth,
            Sex=sex,
        )
        db.session.add(person)
        db.session.flush()
    return person


def get_or_create_address(person_id, street, barangay, municipality, province, region):
    """Find or create an Address record for a person."""
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
        Address.PERSON_ID == person_id,
    ).first()

    if not address:
        address = Address(
            Street=norm_str(street),
            Barangay=norm_str(barangay),
            Municipality=norm_str(municipality),
            Province=norm_str(province),
            Region=norm_str(region),
            PERSON_ID=person_id,
        )
        db.session.add(address)
        db.session.flush()
    return address


def process_party_entries(entries, role, subpoena):
    """Process form party entries: create/find persons, addresses, and link to subpoena."""
    for entry in entries:
        person = get_or_create_person(
            entry.first_name.data,
            entry.middle_name.data,
            entry.last_name.data,
            entry.suffix.data,
            entry.birth_date.data,
            entry.sex.data,
        )
        get_or_create_address(
            person.PERSON_ID,
            entry.street.data,
            entry.barangay.data,
            entry.municipality.data,
            entry.province.data,
            entry.region.data,
        )
        exists = db.session.query(InvolvedParty).filter_by(
            PERSON_ID=person.PERSON_ID,
            Docket_Number=subpoena.Docket_Number,
            Role=role,
        ).first()
        if not exists:
            involved = InvolvedParty(
                PERSON_ID=person.PERSON_ID,
                Docket_Number=subpoena.Docket_Number,
                Role=role,
            )
            db.session.add(involved)


def populate_person_form(entries, role, docket_number):
    """Populate a FieldList of PersonForms with existing involved party data."""
    while len(entries):
        entries.pop_entry()

    involved = (
        db.session.query(InvolvedParty, Person)
        .join(Person, InvolvedParty.PERSON_ID == Person.PERSON_ID)
        .filter(InvolvedParty.Docket_Number == docket_number, InvolvedParty.Role == role)
        .all()
    )

    for inv, person in involved:
        address = (
            db.session.query(Address)
            .filter(Address.PERSON_ID == person.PERSON_ID)
            .order_by(Address.Address_ID.desc())
            .first()
        )
        if not address:
            continue

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


def process_person_entry(entry, role, docket_number):
    """Process a single person form entry for edit operations."""
    person = None

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
        person = (
            db.session.query(Person)
            .filter_by(
                First_name=entry.first_name.data.strip(),
                Middle_name=entry.middle_name.data.strip() or None,
                Last_name=entry.last_name.data.strip(),
                Suffix=entry.suffix.data or None,
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
                Suffix=entry.suffix.data or None,
                Date_of_Birth=entry.birth_date.data,
                Sex=entry.sex.data,
            )
            db.session.add(person)
            db.session.flush()

    if entry.address_id.data:
        address = Address.query.get(int(entry.address_id.data))
        if address:
            address.Street = entry.street.data.strip()
            address.Barangay = entry.barangay.data.strip()
            address.Municipality = entry.municipality.data.strip()
            address.Province = entry.province.data.strip()
            address.Region = entry.region.data.strip()
    else:
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

    involved = InvolvedParty(Docket_Number=docket_number, PERSON_ID=person.PERSON_ID, Role=role)
    db.session.add(involved)


# ---------------------------------------------------------------------------
# Subpoena creation
# ---------------------------------------------------------------------------

def create_subpoena_from_form(form, redirect_target):
    """Shared subpoena creation logic used by admin and secretary routes.

    Args:
        form: validated SubpoenaForm
        template_module: module name for the create template (e.g. 'admin/create_subpoena.html')
        redirect_target: endpoint to redirect to on success
    Returns:
        rendered template or redirect response
    """
    from dateutil.relativedelta import relativedelta

    today = date.today()
    min_birth_date = today - relativedelta(years=18)

    for group_name, entries in {
        "Complainant": form.complainants.entries,
        "Respondent": form.respondents.entries,
    }.items():
        for entry in entries:
            if entry.birth_date.data and entry.birth_date.data > min_birth_date:
                flash(f"❌ {group_name} must be at least 18 years old.", "danger")
                return None  # caller should re-render

    crimes_selected = form.crimes.data or []
    crime_count = len([c for c in crimes_selected if c])
    if crime_count == 0:
        flash("Please select at least one crime.", "danger")
        return None

    try:
        subpoena_date = form.date.data or date.today()
    except Exception:
        subpoena_date = date.today()

    region = "III"
    office = "09"
    type_code = "INV"
    year_code = str(subpoena_date.year)[-2:]
    month_code = chr(65 + subpoena_date.month - 1)
    prefix = f"{region}-{office}-{type_code}-{year_code}{month_code}"

    attempt = 0
    while attempt < MAX_RESERVE_ATTEMPTS:
        attempt += 1
        try:
            last_row = (
                db.session.query(Subpoena)
                .filter(Subpoena.Docket_Number.like(f"{prefix}-%"))
                .order_by(Subpoena.Docket_Number.desc())
                .with_for_update(read=True)
                .first()
            )

            base_serial = 0
            if last_row:
                try:
                    base_serial = int(last_row.Docket_Number.rsplit("-", 1)[-1])
                except Exception:
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

            subpoena = Subpoena(
                Docket_Number=combined_docket,
                Date_=form.date.data,
                Hearing_Date_1=form.hearing_date_1.data,
                Hearing_Date_2=form.hearing_date_2.data,
                Police_Station=form.police_station.data,
                PROSECUTOR_ID=form.prosecutor_id.data,
            )
            db.session.add(subpoena)
            db.session.flush()

            for crime_id in crimes_selected:
                if not crime_id:
                    continue
                try:
                    crime_id_int = int(crime_id)
                except ValueError:
                    continue
                offense = db.session.query(Offense).filter_by(offense_id=crime_id_int).first()
                if offense:
                    link = SubpoenaOffense(Docket_Number=subpoena.Docket_Number, offense_id=offense.offense_id)
                    db.session.add(link)

            pin = generate_pin()
            pin_entry = PinCode(PIN_CODE=pin, Docket_Number=subpoena.Docket_Number)
            db.session.add(pin_entry)

            process_party_entries(form.complainants.entries, 'Complainant', subpoena)
            process_party_entries(form.respondents.entries, 'Respondent', subpoena)

            from app.utils import log_action
            log_action(f"Created subpoena {subpoena.Docket_Number}")

            db.session.commit()
            flash("Subpoena created successfully!", "success")
            return redirect_target

        except IntegrityError:
            db.session.rollback()
            if attempt >= MAX_RESERVE_ATTEMPTS:
                flash("Could not reserve docket number due to concurrent submissions. Please try again.", "danger")
                return None
            continue

        except Exception:
            db.session.rollback()
            logger.exception("Error creating subpoena")
            flash("An unexpected error occurred while creating subpoena.", "danger")
            return None

    flash("Failed to create subpoena. Please retry.", "danger")
    return None


# ---------------------------------------------------------------------------
# Next serial API
# ---------------------------------------------------------------------------

def compute_next_serial(region, office, type_code, date_str, count):
    """Compute the next docket serial. Returns a dict for JSON response."""
    try:
        dt = datetime.strptime(date_str, "%Y-%m-%d")
    except (ValueError, TypeError):
        return None, "Invalid date format (expected YYYY-MM-DD)"

    year_code = str(dt.year)[-2:]
    month_code = chr(65 + dt.month - 1)
    prefix = f"{region}-{office}-{type_code}-{year_code}{month_code}"

    last = (
        db.session.query(Subpoena)
        .filter(Subpoena.Docket_Number.like(f"{prefix}-%"))
        .order_by(Subpoena.Docket_Number.desc())
        .first()
    )

    last_serial = 0
    if last:
        try:
            last_serial = int(last.Docket_Number.rsplit("-", 1)[-1])
        except Exception:
            last_serial = 0

    first_serial = last_serial + 1
    last_serial_calc = first_serial + (count - 1)

    serials = [str(first_serial).zfill(4)]
    if count > 1:
        serials.append(str(last_serial_calc).zfill(4))

    combined = prefix + "-" + "-".join(serials)
    per_crime_dockets = [f"{prefix}-{s}" for s in serials]

    return {
        "docket_combined": combined,
        "per_crime_dockets": per_crime_dockets,
        "serials": serials,
        "prefix": prefix,
    }, None


# ---------------------------------------------------------------------------
# Resolution helpers
# ---------------------------------------------------------------------------

def update_resolution(form, redirect_target):
    """Shared resolution update/creation logic."""
    if form.validate_on_submit():
        docket_number = form.docket_number.data
        verdict = form.verdict.data

        if verdict == 'Pending':
            flash("Cannot submit resolution with 'Pending' as the verdict.", "danger")
            return redirect_target

        court = form.court.data if verdict == 'For Filing' else None
        verdict_date = form.verdict_date.data or datetime.today().date()

        resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()

        if not resolution:
            resolution = Resolution(
                Docket_Number=docket_number,
                Verdict=verdict,
                Court=court,
                Date_=verdict_date,
                Status='Pending',
            )
            db.session.add(resolution)
            db.session.commit()
            from app.utils import log_action
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

            from app.utils import log_action
            if changes:
                log_action(f"Edited Resolution for {docket_number}: " + "; ".join(changes))
            else:
                log_action(f"Re-submitted Resolution for {docket_number} with no field changes")

        flash('Resolution submitted for verification.', 'success')
        return redirect_target

    flash('Failed to submit resolution. Please check inputs.', 'danger')
    return redirect_target


def edit_resolution(docket_number, verdict, court, redirect_target):
    """Shared resolution edit logic."""
    if verdict not in ['For Filing', 'Dismissed']:
        flash("Invalid verdict selection for editing.", "danger")
        return redirect_target

    verdict_date = datetime.utcnow().date()
    resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()

    if not resolution:
        flash("Resolution not found.", "error")
        return redirect_target

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

    from app.utils import log_action
    if changes:
        log_action(f"Edited Resolution for {docket_number}: " + "; ".join(changes))
    else:
        log_action(f"Re-submitted Resolution for {docket_number} with no changes")

    flash("Resolution resubmitted for verification.", "info")
    return redirect_target


# ---------------------------------------------------------------------------
# Verify subpoena / resolution
# ---------------------------------------------------------------------------

def verify_subpoena_action(docket_number, action, comment, redirect_target):
    """Shared subpoena verification logic (approve/deny)."""
    from flask import request

    subpoena = Subpoena.query.get(docket_number)
    if not subpoena:
        flash("Subpoena not found.", "danger")
        return redirect_target

    if action == "approve":
        subpoena.Status = "Approved"
        db.session.commit()
        from app.utils import log_action
        log_action(f"Approved subpoena {docket_number}")
        flash("Subpoena approved.", "success")

    elif action == "deny" and request.method == "POST":
        if not comment:
            flash("Comment is required to deny.", "danger")
            return redirect_target

        subpoena.Status = "Denied"
        denial = DenialComment.query.filter_by(Docket_Number=docket_number, Type="Subpoena").first()
        if denial:
            denial.Comment = comment
            denial.Created_By = current_user.USER_ID
        else:
            denial = DenialComment(
                Docket_Number=docket_number,
                Type="Subpoena",
                Comment=comment,
                Created_By=current_user.USER_ID,
            )
            db.session.add(denial)
        db.session.commit()
        from app.utils import log_action
        log_action(f"Denied subpoena {docket_number} with comment: {comment}")
        flash("Subpoena denied with comment.", "warning")
    else:
        flash("Invalid request.", "danger")

    return redirect_target


def verify_resolution_action(docket_number, action, comment, redirect_target):
    """Shared resolution verification logic (approve/deny)."""
    from flask import request

    resolution = Resolution.query.filter_by(Docket_Number=docket_number).first()
    if not resolution:
        flash("Resolution not found.", "error")
        return redirect_target

    if action == "approve":
        resolution.Status = "Approved"
        resolution.Date_ = datetime.today().date()
        db.session.commit()
        from app.utils import log_action
        log_action(f"Approved Resolution for {docket_number}")
        flash("Resolution approved successfully.", "success")
        return redirect_target

    elif action == "deny" and request.method == "POST":
        if not comment:
            flash("Comment is required to deny the resolution.", "error")
            return redirect_target

        resolution.Status = "Denied"
        db.session.commit()

        denial_comment = DenialComment.query.filter_by(Docket_Number=docket_number, Type="Resolution").first()
        if denial_comment:
            denial_comment.Comment = comment
            denial_comment.Created_By = current_user.USER_ID
        else:
            denial_comment = DenialComment(
                Docket_Number=docket_number,
                Type="Resolution",
                Comment=comment,
                Created_By=current_user.USER_ID,
            )
            db.session.add(denial_comment)
        db.session.commit()

        from app.utils import log_action
        log_action(f"Denied Resolution for {docket_number} with comment: {comment}")
        flash("Resolution denied with comment.", "warning")
        return redirect_target

    else:
        flash("Invalid action.", "error")
        return redirect_target


# ---------------------------------------------------------------------------
# Paginated search/sort helper for SQL views
# ---------------------------------------------------------------------------

def query_paginated_view(base_view, allowed_columns, request_args, extra_where="",
                         extra_params=None, default_sort="Docket_Number"):
    """Generic paginated search/sort over a MySQL view.

    Returns (rows, template_context_dict).
    """
    search_value = request_args.get("search", "").strip()
    search_column = request_args.get("filter", "")
    sort_by = request_args.get("sort", default_sort)
    sort_order = request_args.get("order", "desc")
    page = request_args.get("page", 1, type=int)
    per_page = 6

    sql = f"SELECT * FROM {base_view} WHERE 1=1"
    params = {}

    if extra_where:
        sql += f" {extra_where}"
        params.update(extra_params or {})

    if search_value:
        if search_column and search_column in allowed_columns:
            sql += f" AND {search_column} LIKE :search_value"
            params["search_value"] = f"%{search_value}%"
        else:
            or_conditions = " OR ".join([f"{col} LIKE :search_value" for col in allowed_columns])
            sql += f" AND ({or_conditions})"
            params["search_value"] = f"%{search_value}%"

    if sort_by not in allowed_columns:
        sort_by = default_sort
    order_clause = "ASC" if sort_order == "asc" else "DESC"
    sql += f" ORDER BY {sort_by} {order_clause}"

    count_sql = f"SELECT COUNT(*) as total FROM ({sql}) as subquery"
    total = db.session.execute(text(count_sql), params).scalar()

    total_pages = max((total + per_page - 1) // per_page, 1)
    if page < 1:
        page = 1
    if page > total_pages:
        page = total_pages

    sql += " LIMIT :limit OFFSET :offset"
    params["limit"] = per_page
    params["offset"] = (page - 1) * per_page

    rows = db.session.execute(text(sql), params).mappings().all()

    return rows, {
        "current_sort": sort_by,
        "current_order": sort_order,
        "current_filter": search_column,
        "current_search": search_value,
        "page": page,
        "total_pages": total_pages,
    }


# ---------------------------------------------------------------------------
# Report / statistics helper
# ---------------------------------------------------------------------------

AGE_RANGES = {
    '0-17': (0, 17),
    '18-30': (18, 30),
    '31-45': (31, 45),
    '46-60': (46, 60),
    '61+': (61, 200),
}


def _age_bucket(birth):
    """Bucket a birth date into an age-band label, or None if unknown."""
    if not birth:
        return None
    today = date.today()
    age = today.year - birth.year - ((today.month, today.day) < (birth.month, birth.day))
    if age <= 17:
        return '0-17'
    if age <= 30:
        return '18-30'
    if age <= 45:
        return '31-45'
    if age <= 60:
        return '46-60'
    return '61+'


def _parse_raw_crimes(raw_crimes):
    """Turn submitted crime filter values (ids and/or names) into clean names."""
    final_names = []
    if not raw_crimes:
        return final_names
    if len(raw_crimes) == 1 and raw_crimes[0] and ',' in raw_crimes[0] and not raw_crimes[0].strip().isdigit():
        raw_crimes = [c.strip() for c in raw_crimes[0].split(',') if c.strip()]

    id_list, name_list = [], []
    for item in raw_crimes:
        if not item:
            continue
        if str(item).strip().isdigit():
            try:
                id_list.append(int(item))
            except (ValueError, TypeError):
                name_list.append(item)
        else:
            name_list.append(item)

    if id_list:
        rows = db.session.query(Offense.offense_id, Offense.Name).filter(Offense.offense_id.in_(id_list)).all()
        for r in rows:
            if hasattr(r, 'Name'):
                name_list.append(r.Name)
            elif isinstance(r, (tuple, list)) and len(r) > 1:
                name_list.append(r[1])

    seen = set()
    for n in name_list:
        n2 = n.strip()
        if n2 and n2 not in seen:
            seen.add(n2)
            final_names.append(n2)
    return final_names


def compute_report_data(get, getlist):
    """Shared backend for /reports and /reports/pdf.

    `get` / `getlist` mirror the request.args / request.form interfaces
    (e.g. request.args.get / request.args.getlist). Both routes now share
    exactly the same filtering and aggregation so the dashboard and the PDF
    always agree.
    """
    sql = """
        SELECT * FROM view_reports
        WHERE Verdict IN ('For Filing', 'Dismissed') AND Resolution_Status = 'Approved'
    """
    params = {}

    start_date = get('start_date')
    end_date = get('end_date')
    verdict = get('verdict')
    raw_crimes = getlist('crime')
    station = get('station')
    sex = get('sex')
    age_group = get('age_group')

    if start_date and end_date:
        try:
            start = datetime.strptime(start_date, "%Y-%m-%d").date()
            end = datetime.strptime(end_date, "%Y-%m-%d").date()
            sql += " AND Date_ BETWEEN :start AND :end"
            params["start"] = start
            params["end"] = end
        except (ValueError, TypeError):
            pass

    if verdict in ('For Filing', 'Dismissed'):
        sql += " AND Verdict = :verdict"
        params["verdict"] = verdict

    final_names = _parse_raw_crimes(raw_crimes)
    if final_names:
        crime_conditions = []
        for i, cname in enumerate(final_names):
            key = f"crime_{i}"
            crime_conditions.append(f"Crime LIKE :{key}")
            params[key] = f"%{cname}%"
        sql += " AND (" + " OR ".join(crime_conditions) + ")"

    if station:
        sql += " AND Police_Station = :station"
        params["station"] = station

    reports = db.session.execute(text(sql), params).mappings().all()

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
                min_a, max_a = AGE_RANGES.get(age_group, (0, 200))
                min_date = today.replace(year=today.year - max_a)
                max_date = today.replace(year=today.year - min_a)
                q = q.filter(Person.Date_of_Birth.between(min_date, max_date))
            filtered_dockets = [s.Docket_Number for s in q.distinct().all()]
            reports = [r for r in reports if r["Docket_Number"] in filtered_dockets]

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

    if final_names:
        filtered_crime_count = {name: crime_count.get(name, 0) for name in final_names if crime_count.get(name, 0) > 0}
        if not filtered_crime_count:
            filtered_crime_count = {name: 0 for name in final_names}
        crime_chart_source = filtered_crime_count
        top_case_selected = ", ".join(final_names[:3]) + (" etc" if len(final_names) > 3 else "")
    else:
        crime_chart_source = crime_count
        top_case_selected = None

    def pct(counter):
        s = sum(counter.values()) or 1
        return [{'label': k, 'count': v, 'percent': round(v / s * 100, 1)} for k, v in counter.items()]

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
            bucket = _age_bucket(p.Date_of_Birth)
            if bucket:
                age_count[bucket] = age_count.get(bucket, 0) + 1

    return {
        'total_cases': total_cases,
        'filed': filed,
        'dismissed': dismissed,
        'most_common_crime': most_common_crime,
        'top_case_selected': top_case_selected,
        'final_names': final_names,
        'crime_count': crime_count,
        'station_count': station_count,
        'verdict_count': verdict_count,
        'bar_chart_data': [{'label': k, 'count': v} for k, v in crime_chart_source.items()],
        'verdict_data': pct(verdict_count),
        'sex_data': pct(sex_count),
        'age_data': pct(age_count),
        'station_data': sorted([{'label': k, 'count': v} for k, v in station_count.items()], key=lambda x: -x['count']),
        'start_date': start_date,
        'end_date': end_date,
        'verdict': verdict,
        'station': station,
        'sex': sex,
        'age_group': age_group,
    }
