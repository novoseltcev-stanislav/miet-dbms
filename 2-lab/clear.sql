truncate table room, patient, medical_procedure, patient_procedure;


alter sequence room_id_seq restart with 1;
alter sequence patient_id_seq restart with 1;
alter sequence medical_procedure_id_seq restart with 1;
