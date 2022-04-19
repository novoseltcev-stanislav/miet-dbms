class CustomException(Exception):
    def __init__(self, http_code, message, **params):
        self.http_code = http_code
        self.message = message
        self.body = {**params}

    @property
    def json(self):
        return {
            'error': type(self).__name__,
            'msg': self.message,
            'body': self.body
        }


class NoSuchEntityError(CustomException):
    def __init__(self, message: str = 'Нет такой сущности.'):
        super(type(self), self).__init__(http_code=404, message=message)


class LogicError(CustomException):
    def __init__(self, message='Логическая ошибка.', http_code=409):
        super(type(self), self).__init__(http_code=http_code, message=message)
