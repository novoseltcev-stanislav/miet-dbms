from marshmallow import Schema, fields
from marshmallow.validate import Length


class PatientSchema(Schema):
    id = fields.Integer(required=True)
    room_id = fields.Integer(required=True)
    name = fields.String(required=True, validation=Length(max=50))
    surname = fields.String(required=True, validation=Length(max=50))
    patronymic = fields.String(required=False, validation=Length(max=50))
    birthday = fields.Date(required=True)
