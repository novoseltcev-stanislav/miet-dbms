from typing import List, Tuple, Type, TypeVar, Generic

from app.errors import NoSuchEntityError
from .repository import Repository
from app.db import db

T = TypeVar('T')


class Service(Generic[T]):
    def __init__(self, model: Type[db.Model]):
        self.model = model
        self.repository = Repository(model)

    def get_by_id(self, entity_id: int) -> T:
        activity = self.repository.get_by_id(entity_id)
        if not activity:
            raise NoSuchEntityError()
        return activity

    def get_all(self, page: int) -> Tuple[List[T], int]:
        return self.repository.get_all(page=page)

    def create(self, data: dict) -> int:
        activity = self.model(**data)
        self.repository.create(activity)
        return activity.id

    def update(self, data: dict) -> None:
        return self.repository.update(**data)

    def delete(self, entity_id: int):
        return self.repository.delete_by_id(entity_id)
