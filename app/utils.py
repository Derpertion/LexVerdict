from app.models import User, Username, Password, db
from app.models import LogTable 
from flask_login import current_user
from datetime import datetime, date


def check_login_credentials(username, password):
    username_entry = Username.query.filter_by(Username=username).first()
    if not username_entry:
        return None
    
    password_entry = Password.query.filter_by(USER_ID=username_entry.USER_ID, Password=password).first()
    if not password_entry:
        return None
    
    user = User.query.get(username_entry.USER_ID)
    return user 

from flask_login import current_user
from datetime import datetime
from app import db
from app.models import LogTable  # adjust import if needed

def log_action(action, user_id=None):
    """
    Logs an action with an optional user_id.
    Falls back to current_user if authenticated.
    """
    if user_id is None:
        try:
            # Use current_user if available and authenticated
            user_id = current_user.USER_ID if hasattr(current_user, 'USER_ID') else None
        except Exception:
            user_id = None

    log_entry = LogTable(
        USER_ID=user_id,
        Action=action,
        Timestamp=datetime.now()
    )

    db.session.add(log_entry)
    db.session.commit()


def get_subpoena_changes(old, new):
    tracked_fields = {
        "Crime": "Crime",
        "Date_": "Date",
        "Hearing_Date_1": "Hearing Date 1",
        "Hearing_Date_2": "Hearing Date 2",
        "Police_Station": "Police Station",
        "PROSECUTOR_ID": "Prosecutor"
    }

    changes = []
    for field, label in tracked_fields.items():
        old_value = old.get(field)
        new_value = getattr(new, field)

        # Convert datetime or date to string for readable comparison
        if isinstance(old_value, (datetime, date)):
            old_value = old_value.isoformat() if old_value else ""
        if isinstance(new_value, (datetime, date)):
            new_value = new_value.isoformat() if new_value else ""

        if str(old_value).strip() != str(new_value).strip():
            changes.append(f'{label} from "{old_value}" to "{new_value}"')

    return ", ".join(changes)
