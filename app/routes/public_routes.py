from flask import Blueprint, render_template, flash, redirect, url_for
from app.models import db
from app.forms import DocketForm
from sqlalchemy import text

public_bp = Blueprint('public', __name__, url_prefix='/case')


@public_bp.route('/', methods=['GET', 'POST'])
def view_case():
    form = DocketForm()

    if form.validate_on_submit():
        docket_number = form.docket.data.strip()
        pin = form.pin.data.strip()

        query = text("""
            SELECT * FROM view_case_lookup
            WHERE Docket_Number = :docket AND PIN_CODE = :pin
        """)
        result = db.session.execute(query, {'docket': docket_number, 'pin': pin}).mappings().fetchone()

        if result:
            return render_template('case_lookup.html', case_data=dict(result))
        else:
            flash('Invalid Docket Number or PIN Code.', 'danger')

    return render_template('docket.html', form=form)