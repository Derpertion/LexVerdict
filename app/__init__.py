import os
import logging
from flask import Flask, session
from flask_login import LoginManager
from flask_wtf import CSRFProtect
from datetime import timedelta
from app.models import db, User
from config import get_config

csrf = CSRFProtect()


def create_app():
    app = Flask(__name__, template_folder='../templates', static_folder='../static')

    # Load config
    config_class = get_config()
    app.config.from_object(config_class)

    # Ensure SECRET_KEY is set
    if not app.config.get('SECRET_KEY') or app.config['SECRET_KEY'] in ('your_secret_key', 'lexverdict-secret-key'):
        app.config['SECRET_KEY'] = os.urandom(32).hex()

    # Setup logging
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s %(levelname)s %(name)s: %(message)s'
    )

    db.init_app(app)
    csrf.init_app(app)

    login_manager = LoginManager()
    login_manager.init_app(app)
    login_manager.login_view = 'auth.login'

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # BLUEPRINTS
    from app.routes.auth_routes import auth_bp
    from app.routes.admin_routes import admin_bp
    from app.routes.public_routes import public_bp
    from app.routes.secret_routes import secret_bp
    from app.routes.prosecutor_routes import prosecutor_bp
    from app.routes.ps_routes import ps_bp

    app.register_blueprint(auth_bp)
    app.register_blueprint(admin_bp)
    app.register_blueprint(public_bp)
    app.register_blueprint(secret_bp)
    app.register_blueprint(prosecutor_bp)
    app.register_blueprint(ps_bp)

    # Error handlers
    @app.errorhandler(404)
    def not_found(e):
        return "Page not found", 404

    @app.errorhandler(500)
    def internal_error(e):
        db.session.rollback()
        return "Internal server error", 500

    return app
