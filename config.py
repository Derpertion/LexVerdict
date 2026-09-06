import os
from datetime import timedelta

basedir = os.path.abspath(os.path.dirname(__file__))

SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'lexverdict.db')  # Switch to MySQL/PostgreSQL later
SQLALCHEMY_TRACK_MODIFICATIONS = False
SECRET_KEY = 'lexverdict-secret-key'  # Replace with something secure
PERMANENT_SESSION_LIFETIME = timedelta(hours=3)
SESSION_PERMANENT = True