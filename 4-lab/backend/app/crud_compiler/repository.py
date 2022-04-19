from typing import List, Tuple, Type, Generic, TypeVar

from flask import current_app
from flask_sqlalchemy import Pagination

from app import db

T = TypeVar('T')


class Repository(Generic[T]):
    PAGE_LENGTH = current_app.config['PAGE_LENGTH']

    def __init__(self, model: Type[db.Model]):
        self.model = model
        self.session: db.Session = db.session
        self.query: db.Query = self.session.query

    def get_by_id(self, entity_id: int) -> T:
        return self.query(self.model).get(entity_id)

    def get_all(self, page: int) -> Tuple[List[T], int]:
        pagination: Pagination = self.query(self.model).paginate(page, self.PAGE_LENGTH, error_out=False)
        return pagination.items, pagination.pages

    def create(self, entity: T) -> None:
        self.session.add(entity)
        self.session.commit()

    def update(self, id: int, **params) -> None:
        self.query(self.model).filter(self.model.id == id).update(params)
        self.session.commit()

    def delete_by_id(self, entity_id: int) -> None:
        self.query(self.model).filter_by(id=entity_id).delete()
        self.session.commit()
