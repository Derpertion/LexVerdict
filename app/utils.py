import logging
from app.models import db, LogTable
from flask_login import current_user
from datetime import datetime, date

logger = logging.getLogger(__name__)


def log_action(action, user_id=None):
    """Logs an action with an optional user_id. Falls back to current_user."""
    if user_id is None:
        try:
            user_id = current_user.USER_ID if hasattr(current_user, 'USER_ID') else None
        except Exception:
            user_id = None

    try:
        log_entry = LogTable(
            USER_ID=user_id,
            Action=action,
            Timestamp=datetime.now()
        )
        db.session.add(log_entry)
        db.session.commit()
    except Exception:
        db.session.rollback()
        logger.exception("Failed to log action: %s", action)


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

        if isinstance(old_value, (datetime, date)):
            old_value = old_value.isoformat() if old_value else ""
        if isinstance(new_value, (datetime, date)):
            new_value = new_value.isoformat() if new_value else ""

        if str(old_value).strip() != str(new_value).strip():
            changes.append(f'{label} from "{old_value}" to "{new_value}"')

    return ", ".join(changes)
