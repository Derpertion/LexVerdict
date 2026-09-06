from flask import Flask, session
from flask_login import LoginManager
from datetime import timedelta
from app.models import db, User  # use the one from models.py

def create_app():
    app = Flask(__name__, template_folder='../templates', static_folder='../static')
    app.secret_key = 'your_secret_key'

    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/lexverdict'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)

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

    return app
