import os
from distutils.util import strtobool
from os import environ
from pathlib import Path

from dotenv import load_dotenv
from flask import Flask
from flask_cors import CORS

from app.db import db
from app.entities.models import *


def create_app() -> Flask:
    app = Flask(__name__, instance_relative_config=True)
    app.url_map.strict_slashes = False
    CORS(app)

    path = Path(os.path.dirname(__file__))

    load_dotenv(os.path.join(path.parent.absolute(), '.env'))

    app.config.from_mapping(
        DEBUG=strtobool(environ.get('DEBUG')),

        SQLALCHEMY_DATABASE_URI=environ.get('SQLALCHEMY_DATABASE_URI'),
        SQLALCHEMY_TRACK_MODIFICATIONS=strtobool(environ.get('SQLALCHEMY_TRACK_MODIFICATIONS')),

        SECRET_KEY=environ.get('SECRET_KEY'),
        PAGE_LENGTH=10,

        TMP_FILE_PATH=environ.get('TMP_FILE_PATH'),
        PERMANENT_FILE_PATH=environ.get('PERMANENT_FILE_PATH')
    )

    app.app_context().push()
    db.init_app(app)

    from app.routes import register_routes
    register_routes()
    return app


if __name__ == '__main__':
    create_app().run()
