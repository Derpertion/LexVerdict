from flask import Blueprint, render_template, flash
from app.models import Subpoena
from app.forms import DocketForm 

public_bp = Blueprint('public', __name__, url_prefix='/case')

@public_bp.route('/', methods=['GET', 'POST'])
def view_case():
    form = DocketForm()
    subpoena = None

    if form.validate_on_submit():
        docket = form.docket.data
        pin = form.pin.data

        subpoena = Subpoena.query.filter_by(Docket_Number=docket, PIN_Code=pin).first()

        if subpoena:
            return render_template('case_lookup.html', subpoena=subpoena)
        else:
            flash('Invalid Docket Number or PIN Code.', 'danger')

    return render_template('docket.html', form=form)

