from app.crud_compiler.controller import Controller
from app.entities import *


class RoomController(Controller):
    def __init__(self):
        super(RoomController, self).__init__(RoomModel, RoomSchema)


class PatientController(Controller):
    def __init__(self):
        super(PatientController, self).__init__(PatientModel, PatientSchema)


class ProcedureController(Controller):
    def __init__(self):
        super(ProcedureController, self).__init__(ProcedureModel, ProcedureSchema)

