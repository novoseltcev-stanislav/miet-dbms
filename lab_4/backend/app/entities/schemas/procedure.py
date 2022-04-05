from app.db import db


class Procedure(db.Model):
    __tablename__ = 'medical_procedure'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(256))
    description = db.Column(db.Text, nullable=True)
