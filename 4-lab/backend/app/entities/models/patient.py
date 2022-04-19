from app.db import db


class PatientModel(db.Model):
    __tablename__ = 'patient'

    id = db.Column(db.Integer, primary_key=True)
    room_id = db.Column(db.Integer, db.ForeignKey('room.id'))
    name = db.Column(db.String(50))
    surname = db.Column(db.String(50))
    patronymic = db.Column(db.String(50), nullable=True)
    birthday = db.Column(db.Date)
