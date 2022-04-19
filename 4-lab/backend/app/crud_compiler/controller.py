from typing import Generic, TypeVar, Type

from flask import jsonify, request
from flask.views import MethodView
from marshmallow import Schema

from app.db import db
from app.utils.schema import PageSchema
from .service import Service


T = TypeVar('T')


class Controller(MethodView):
    def __init__(self, model: Type[db.Model], schema: Type[Schema]):
        self.schema = schema
        self.service = Service(model)
        super(Controller, self).__init__()

    def get(self, id: int = None):
        print(f'{id=}')
        if id:
            return self._get_entity_by_id(id), 200
        return self._get_all(), 200

    def _get_entity_by_id(self, id: int):
        activity = self.service.get_by_id(id)
        return jsonify(self.schema().dump(activity))

    def _get_all(self):
        page = PageSchema(unknown='EXCLUDE').load(request.args)['page']
        patients, pages = self.service.get_all(page)
        return jsonify(data=self.schema(many=True).dump(patients), meta={'pages': pages})

    def post(self):
        data = self.schema(exclude=('id',), unknown='EXCLUDE').load(request.json)
        patient_id = self.service.create(data)
        return jsonify(patient_id=patient_id), 201

    def put(self, id: int):
        view_data = request.json
        view_data['id'] = id
        data = PageSchema(unknown='EXCLUDE').load(view_data)
        self.service.update(data)
        return jsonify(), 204

    def delete(self, id: int):
        data = self.schema(only=('id',)).load({'id': id})
        self.service.delete(data['id'])
        return jsonify(), 204
