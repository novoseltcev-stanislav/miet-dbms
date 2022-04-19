from marshmallow import Schema, fields
from marshmallow.validate import Length


class ProcedureSchema(Schema):
    id = fields.Integer(required=True)
    room_id = fields.Integer(required=True)
    name = fields.String(required=True, validation=Length(max=256))
    description = fields.String(required=False, allow_none=True)
