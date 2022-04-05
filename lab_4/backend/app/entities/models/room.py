from app.db import db


class Room(db.Model):
    __tablename__ = 'room'

    id = db.Column(db.Integer, primary_key=True)
    number = db.Column(db.String(32))
    capacity = db.Column(db.Integer, nullable=True)
