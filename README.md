# LexVerdict — Case Management & Subpoena Tracking System

LexVerdict is a Flask-based case management system built for Philippine law enforcement offices. It digitizes the subpoena workflow — from case filing and verification to resolution — while providing role-based access for secretaries, prosecutors, process servers (PS), and system administrators. It also generates court-ready **PDF subpoenas** and printable **case statistics reports**.

## Features

- **Role-based dashboards** for `superuser` (admin), `Secretary`, `Prosecutor`, and `PS` (process server) with route-level access control.
- **Subpoena management** — create, edit, view, and track subpoenas with complainant/respondent parties, offenses, hearing dates, and police stations.
- **Verification workflow** — subpoenas and resolutions flow through a approve / deny pipeline with denial comments and full audit logging.
- **Resolution tracking** — record verdicts (`For Filing` / `Dismissed`) per case.
- **PDF subpoena generation** — multi-page, court-formatted subpoenas (DOJ/NPS letterhead) generated via WeasyPrint.
- **Case report dashboard & PDF export** — filter cases by date range, verdict, crime type, police station, sex, and age group; view Chart.js visualizations and summary tables, then export a landscape A4 PDF report.
- **PDF generation** — reports are generated with WeasyPrint, so the dashboard and PDF always share the exact same filter logic.
- **Public case lookup** — anyone can look up a resolved case online using a Docket Number + PIN code.
- **User management** — create, edit, archive, restore, and log user activity. Archived users cannot log in.
- **Offense catalog management** — maintain the list of crimes and their law references.

## Tech Stack

| Layer      | Technology |
|------------|-----------|
| Backend    | Python 3, Flask, Flask-Login, Flask-WTF / WTForms |
| Database   | MySQL via SQLAlchemy (PyMySQL driver) |
| PDF        | WeasyPrint (HTML → PDF) |
| Frontend   | Jinja2 templates, Chart.js, jQuery, Select2 |

## Role Overview

| Role        | Primary responsibilities |
|-------------|--------------------------|
| `superuser` | Full system administration: manage users, crimes, cases, verify filings, generate reports and PDFs |
| `Secretary` | Create and manage subpoenas, submit for verification |
| `Prosecutor`| Review and verify subpoenas/resolutions, track case statuses |
| `PS`        | Process server — read-only case lists / dashboards |

## Project Structure

```
.
├── app/
│   ├── __init__.py          # App factory, blueprints, CSRF
│   ├── models.py            # SQLAlchemy ORM models
│   ├── forms.py             # Flask-WTF forms
│   ├── rbac.py              # role_required decorator
│   ├── services.py          # Business logic incl. shared report query helper
│   ├── utils.py             # Audit logging helpers
│   └── routes/
│       ├── admin_routes.py      # Admin dashboard, cases, verify, reports, users
│       ├── secret_routes.py     # Secretary workflows
│       ├── prosecutor_routes.py # Prosecutor workflows
│       ├── ps_routes.py         # Process server views
│       ├── auth_routes.py       # Login / logout / landing page
│       └── public_routes.py     # Public docket + PIN lookup
├── templates/           # Jinja2 templates (organised by role)
├── static/              # CSS, JS, logos
├── config.py            # Environment-aware Flask config
├── run.py               # App entry point
└── requirements.txt
```

## Getting Started

### Prerequisites

- Python 3.10+
- MySQL server (the app expects a database named `lexverdict` by default)
- **GTK3 runtime** for WeasyPrint PDF generation on Windows:
  - Download the installer from the [GTK for Windows Runtime Environment Installer](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases)
  - Run `gtk3-runtime-*.exe` and install it

### Installation

```bash
# 1. Create and activate a virtual environment (Windows)
python -m venv venv
venv\Scripts\activate

# 2. Install dependencies
pip install -r requirements.txt
```

### Database Setup

The app does **not** create its schema automatically — it assumes the MySQL database already exists. In MySQL:

```sql
CREATE DATABASE IF NOT EXISTS lexverdict CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

The application relies on several database **views** that must be created ahead of time in the database (they are read by the app but are not included in this repository):

- `view_reports` — normalized case rows consumed by the reports dashboard and PDF export
- `view_case_lookup` — public case lookup data (docket + PIN)
- `view_manage_users` — user management listing

If your tables are created by external migration tooling (e.g. MySQL Workbench), re-create these views after importing your schema.

### Run the app

```bash
python run.py
```

Then open `http://127.0.0.1:5000` in your browser.

## Configuration

All settings live in `config.py` and can be overridden with environment variables:

| Variable       | Default                               | Purpose                             |
|----------------|---------------------------------------|-------------------------------------|
| `SECRET_KEY`   | random `os.urandom(32).hex()`          | Flask session signing               |
| `DATABASE_URL` | `mysql+pymysql://root:@localhost/lexverdict` | SQLAlchemy database connection |
| `FLASK_ENV`    | `production`                          | `development` enables debug mode    |

Configure the config class by setting `FLASK_ENV` to `development` or `production`.

## Usage

1. **Log in** with an account assigned to one of the roles (`superuser`, `Secretary`, `Prosecutor`, `PS`).
2. As an admin/secretary, **create a subpoena** — record offenders, respondents, offenses, hearing dates, and the police station.
3. **Verify** subpoenas and resolutions — either approve them for filing or deny them with a comment.
4. Admin users can **generate the subpoena PDF** and open the **Case Report** page to filter data and export a **PDF report**.
5. Case participants can verify a filed case through the public lookup using the Docket Number and PIN printed on the subpoena.

## Report Generation

- The **Case Report** page (`/reports`, admin only) lets you filter by:
  - Date range, verdict (Filed / Dismissed), case type (crime), police station, sex, and age group.
- Charts are rendered client-side with Chart.js and embedded into the exported PDF as images.
- The **PDF export** (`/reports/pdf`) re-runs the same shared query helper used by the dashboard (`app/services.py`), so on-screen and PDF numbers always match.
- WeasyPrint is required to generate both the case reports and subpoena PDFs — make sure the GTK3 runtime is installed.

## Troubleshooting

- **WeasyPrint errors** — ensure the GTK3 runtime is installed and reachable; on Windows this is a common cause of PDF generation failures.
- **PDF generation fails on `/reports/pdf`** — confirm a valid CSRF token is submitted (the page includes it automatically) and that filters are well-formed.
- **Database connection errors** — verify MySQL is running and `DATABASE_URL` matches your credentials.

## License

This project is provided for educational and internal office use. No license is specified.
