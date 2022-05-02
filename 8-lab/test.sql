CREATE TEMPORARY TABLE IF NOT EXISTS saved_patient
    AS SELECT * FROM patient
    WHERE id=1;

CREATE TEMPORARY TABLE IF NOT EXISTS saved_patient_procedure
    AS SELECT * FROM patient_procedure
    WHERE patient_id=1;

SELECT n_procedures FROM patient WHERE id=1;

INSERT INTO patient_procedure (patient_id, medical_procedure_id, assigned_quantity) VALUES (1, 2, 10);
SELECT n_procedures FROM patient WHERE id=1;

DELETE FROM public.patient_procedure WHERE patient_id=1 AND medical_procedure_id=2;
SELECT n_procedures FROM patient WHERE id=1;

SELECT * FROM patient_procedure
    WHERE patient_id=1;

DELETE FROM patient WHERE id=1;

SELECT * FROM patient_procedure
    WHERE patient_id=1;

ALTER TABLE patient DROP CONSTRAINT patient_pk CASCADE;
ALTER TABLE patient ALTER COLUMN id DROP identity;
INSERT INTO patient SELECT * FROM saved_patient;
UPDATE patient SET n_procedures = 0 WHERE id = 1;
ALTER TABLE patient ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY (id);

ALTER TABLE patient_procedure DROP CONSTRAINT patient_procedure_pk CASCADE;
INSERT INTO patient_procedure SELECT * FROM saved_patient_procedure;
ALTER TABLE patient_procedure ADD CONSTRAINT patient_procedure_pk PRIMARY KEY (patient_id, medical_procedure_id);

DROP TABLE saved_patient;
DROP TABLE saved_patient_procedure;