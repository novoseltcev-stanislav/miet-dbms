from flask import current_app

from .controllers import *


def register_routes():
    api_prefix = '/dbms-api'

    room_view = RoomController.as_view('rooms')
    current_app.add_url_rule(api_prefix + '/rooms', view_func=room_view)
    current_app.add_url_rule(api_prefix + '/rooms/<int:id>', view_func=room_view)

    patient_view = PatientController.as_view('patients')
    current_app.add_url_rule(api_prefix + '/patients', view_func=patient_view)
    current_app.add_url_rule(api_prefix + '/patients/<int:id>', view_func=patient_view)

    procedure_view = ProcedureController.as_view('procedures')
    current_app.add_url_rule(api_prefix + '/procedures', view_func=procedure_view)
    current_app.add_url_rule(api_prefix + '/procedures/<int:id>', view_func=procedure_view)
