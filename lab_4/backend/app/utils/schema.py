from marshmallow import Schema, fields
from marshmallow.validate import Range


class PageSchema(Schema):
    page = fields.Integer(required=False, load_only=True, load_default=1, validate=Range(min=1))
