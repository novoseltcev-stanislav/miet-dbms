ALTER TABLE public.patient DROP COLUMN IF EXISTS n_procedures;

DROP TRIGGER IF EXISTS on_add_procedure_to_patient ON patient_procedure;
DROP FUNCTION IF EXISTS inc_patient_procedure();

DROP TRIGGER IF EXISTS on_delete_procedure_from_patient ON patient_procedure;
DROP FUNCTION IF EXISTS dec_patient_procedure();

DROP TRIGGER IF EXISTS on_delete_patient ON patient;
DROP FUNCTION IF EXISTS delete_patient_procedures();

DROP TABLE IF EXISTS saved_patient;
DROP TABLE IF EXISTS saved_patient_procedure;
