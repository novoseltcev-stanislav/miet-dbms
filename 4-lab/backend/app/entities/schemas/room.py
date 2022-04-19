from marshmallow import Schema, fields
from marshmallow.validate import Length


class RoomSchema(Schema):
    id = fields.Integer(required=True)
    number = fields.String(required=True, validation=Length(max=32))
    capacity = fields.Integer(required=False, allow_none=True)
