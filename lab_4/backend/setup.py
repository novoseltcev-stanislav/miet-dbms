from setuptools import setup, find_packages

requires = [
    'flask',
    'flask-sqlalchemy',
    'sqlalchemy',
    'flask_cors',
    'marshmallow',
    'python-dotenv',
    'psycopg2-binary'
]

dev_requires = []

test_requires = []

setup(
    name='app',
    version='0.0',
    description='dbms-backend',
    install_requires=requires,
    extras_require={
        'dev': dev_requires,
        'test': test_requires
    },
    packages=find_packages()
)
