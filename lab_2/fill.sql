INSERT INTO room (
    number, 
    capacity
  ) 
  SELECT substr(md5(random()::text), 1, 32)::varchar, 
         trunc(random() * 7 + 1) 
           FROM generate_series(0, 200);

INSERT INTO patient (
    room_id, 
    name, 
    surname, 
    patronymic, 
    birthday
  ) 
  SELECT trunc(1 + random() * 200), 
         substr(md5(random()::text), 1, 32)::varchar,
         substr(md5(random()::text), 1, 32)::varchar,
         substr(md5(random()::text), 1, 32)::varchar,
         '1\1\2000'::date - trunc(random() * 365 * 60) * '1 day'::interval
           FROM generate_series(1, 1000);

INSERT INTO medical_procedure (
    name, 
    description
  )
  SELECT substr(md5(random()::text), 1, 32)::varchar,
         substr(md5(random()::text), 1, 255)::text
           FROM generate_series(0, 100);

INSERT INTO patient_procedure (
    patient_id, 
    medical_procedure_id, 
    duration, 
    assigned_quantity 
  ) 
  SELECT id, trunc(1 + random() * 24),
         trunc(random() * 60) * '1 minute'::interval,
         trunc(1 + random() * 8)
           FROM patient;

INSERT INTO patient_procedure (
    patient_id, 
    medical_procedure_id, 
    duration, 
    assigned_quantity 
  ) 
  SELECT id, trunc(26 + random() * 24),
         trunc(random() * 60) * '1 minute'::interval,
         trunc(1 + random() * 8)
           FROM patient;

INSERT INTO patient_procedure (
    patient_id, 
    medical_procedure_id, 
    duration, 
    assigned_quantity 
  ) 
  SELECT id, trunc(51 + random() * 24),
         trunc(random() * 60) * '1 minute'::interval,
         trunc(1 + random() * 8)
           FROM patient;

INSERT INTO patient_procedure (
    patient_id, 
    medical_procedure_id, 
    duration, 
    assigned_quantity 
  ) 
  SELECT id, trunc(76 + random() * 24),
         trunc(random() * 60) * '1 minute'::interval,
         trunc(1 + random() * 8)
           FROM patient;
