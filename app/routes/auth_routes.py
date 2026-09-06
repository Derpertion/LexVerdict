from flask import Blueprint, render_template, redirect, url_for, flash, request
from app.forms import LoginForm, DocketForm
from app.utils import log_action 
from flask_login import login_user, login_required, logout_user
from app.models import Username
from app.models import db
from sqlalchemy import text
from werkzeug.security import check_password_hash

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/')
def home():
    return redirect(url_for('auth.landing_page'))  

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()

    if form.validate_on_submit():
        username_entry = Username.query.filter_by(Username=form.username.data).first()

        if username_entry and username_entry.user:
            user = username_entry.user
            password_entry = user.password[0] if user.password else None

            if user.Archived == 1:
                flash('This account has been archived. Please contact the administrator.', 'warning')
                log_action(f"Archived user '{form.username.data}' attempted to log in", user_id=user.USER_ID)
                return redirect(url_for('auth.login'))

            if password_entry and check_password_hash(password_entry.Password, form.password.data):
                login_user(user)
                log_action(f"User '{form.username.data}' logged in", user_id=user.USER_ID)
                flash('Login successful', 'success')

                if user.Role == 'superuser':
                    return redirect(url_for('admin.dashboard'))
                elif user.Role == 'Secretary':
                    return redirect(url_for('secretary.dashboard'))
                elif user.Role == 'Prosecutor':
                    return redirect(url_for('prosecutor.dashboard'))
                elif user.Role == 'PS':
                    return redirect(url_for('process_server.dashboard'))
                else:
                    flash('Unknown role. Contact admin.', 'danger')
                    return redirect(url_for('auth.login'))
            else:
                flash('Invalid username or password', 'danger')
                log_action(f"Failed login attempt for '{form.username.data}'", user_id=user.USER_ID)
        else:
            flash('Invalid username or password', 'danger')
            log_action(f"Failed login attempt for unknown username '{form.username.data}'")

    return render_template('login.html', form=form)

@auth_bp.route('/docket', methods=['GET', 'POST'])
def docket_lookup():
    form = DocketForm()

    if request.method == 'POST' and form.validate_on_submit():
        docket_number = form.docket.data.strip()
        pin = form.pin.data.strip()

        query = text("""
            SELECT * FROM view_case_lookup
            WHERE Docket_Number = :docket AND PIN_CODE = :pin
        """)
        result = db.session.execute(query, {'docket': docket_number, 'pin': pin}).mappings().fetchone()

        if result:
            case_data = dict(result)
            return render_template('case_lookup.html', case_data=case_data)
        else:
            flash('Invalid Docket Number or PIN', 'danger')
            return redirect(url_for('auth.docket_lookup'))

    return render_template('docket.html', form=form)

@auth_bp.route('/logout')
@login_required
def logout():
    log_action("User logged out")
    logout_user()
    flash('You have been logged out.', 'info')
    return redirect(url_for('auth.login'))

@auth_bp.route('/landing_page')
def landing_page():
    return render_template('/landing_page.html')