# LexVerdict

**Subpoena and Case Resolution Monitoring System**  
For the Office of the Provincial Prosecutor (OPP), Nueva Ecija

> A web-based system for managing subpoenas, monitoring case resolutions, and providing secure case lookup.

## Overview

LexVerdict was developed to replace a manual workflow that relied on paper records, handwritten logs, and Excel files. It provides a centralized system for creating, verifying, approving, and tracking subpoenas and case resolutions.

The project focuses on three things:

- **Case & subpoena management**
- **Resolution monitoring**
- **Secure reporting and case lookup**

## Key Features

- 🔐 **Role-based authentication** for administrators, prosecutors, secretaries, and process servers
- 📋 **Subpoena management** — create, edit, verify, approve, deny, and track subpoenas
- ⚖️ **Resolution management** — record and monitor case resolutions
- 🔎 **Public case lookup** using Docket Number + PIN
- 📄 **PDF generation** for subpoenas and transmittals
- 📊 **Reports & analytics** for case trends and distributions
- 📝 **Activity logging** for accountability and traceability
- 🛡️ **Access control** for protecting restricted case information

## Workflow

```text
Secretary
   │
   ▼
Create Subpoena
   │
   ▼
Assistant Prosecutor
   │
   ├── Verify / Review
   │
   ▼
Provincial Prosecutor / Chief Admin
   │
   ├── Approve
   └── Deny + Comment
   │
   ▼
Resolution Recorded
   │
   ▼
Approved Case
   │
   └── Public Lookup (Docket No. + PIN)
```

## User Roles

| Role | Main Responsibilities |
|---|---|
| **Provincial Prosecutor / Chief Admin** | Final approval, user management, reports, logs, case oversight |
| **Assistant Prosecutor** | Review and verify subpoenas; approve or deny assigned cases |
| **Secretary** | Encode case information, create subpoenas, submit cases, monitor status |
| **Process Server** | Access subpoena information needed for service operations |
| **Complainant / Respondent** | Limited case lookup using Docket Number and PIN |

## Technology Stack

**Backend**
- Python
- Flask
- Flask-SQLAlchemy
- Flask-Login
- Flask-WTF
- PyMySQL

**Frontend**
- HTML
- CSS
- JavaScript
- Bootstrap
- Select2
- Chart.js

**Database**
- MySQL / MariaDB

**Document Generation**
- WeasyPrint

**Development Tools**
- XAMPP
- Visual Paradigm
- Figma

## Architecture

```text
┌───────────────────────┐
│      Web Browser      │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│      Flask App        │
│  Routes / Forms / UI  │
└───────────┬───────────┘
            │
      ┌─────┴─────┐
      ▼           ▼
┌───────────┐ ┌──────────────┐
│ MySQL /   │ │ PDF Generator│
│ MariaDB   │ │  WeasyPrint  │
└───────────┘ └──────────────┘
```

## Security

LexVerdict includes:

- Authentication and role-based authorization
- Password protection
- PIN-protected public lookup
- Restricted access to case information
- User activity logging
- Input validation
- Controlled access to administrative functions

Because the system handles sensitive legal records, access to information is intentionally limited according to user roles.

## Project Scope

LexVerdict covers:

- Subpoena creation and management
- Subpoena verification and approval
- Case resolution recording and monitoring
- Transmittal generation
- User/account management
- Activity logs
- Reporting and analytics
- PIN-based public lookup

### Out of Scope

The project does **not** aim to provide:

- Evidence management
- Court scheduling
- Complete end-to-end court case management
- AI-based legal decision-making
- Automated legal judgments

## Evaluation

The system was evaluated using ISO/IEC 25010-based software quality criteria.

**End-user evaluation:** **3.81 — Functional**

The evaluation covered:

- Functional suitability
- Performance efficiency
- Compatibility
- Usability

## Development

The project followed a **Developmental Research Approach** using a **Modified Waterfall Model**, covering:

1. Requirements Analysis
2. System Design
3. Implementation
4. Testing
5. Deployment
6. Maintenance

The database design followed the **Database Life Cycle (DBLC)** approach.

## Repository Structure

A typical project structure is:

```text
LexVerdict/
├── app/
│   ├── routes/
│   ├── models/
│   ├── forms/
│   ├── templates/
│   └── static/
├── database/
├── docs/
├── generated/
├── requirements.txt
├── config.py
└── run.py
```

> The actual repository structure may differ depending on the current implementation.

## Getting Started

### Requirements

- Python 3.x
- MySQL or MariaDB
- XAMPP or another local database environment
- WeasyPrint dependencies

### Installation

```bash
git clone <repository-url>
cd LexVerdict

python -m venv venv
```

Activate the virtual environment:

**Windows**
```bash
venv\Scripts\activate
```

**Linux / macOS**
```bash
source venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Configure the database and application environment, then start the Flask application:

```bash
python run.py
```

> Database credentials, secret keys, real case records, and production PINs should never be committed to the repository.

## Academic Project

LexVerdict was developed as an academic software project focused on applying web development, database design, system analysis, security, and software quality principles to a real-world administrative workflow.

The project was designed around the operational requirements of the **Office of the Provincial Prosecutor of Nueva Ecija**.

## Status

**Completed academic project / system prototype**

The repository contains the implementation and supporting materials intended for educational, demonstration, and portfolio purposes.

## License

No open-source license is currently specified.

If this repository is intended for public distribution, add an appropriate license before allowing others to reuse or redistribute the code.

---

**LexVerdict** — Subpoena and Case Resolution Monitoring System
