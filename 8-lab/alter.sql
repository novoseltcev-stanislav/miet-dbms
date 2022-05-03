ALTER TABLE public.patient
    ADD COLUMN n_procedures int;

UPDATE public.patient
    SET n_procedures = nums
    FROM (
         SELECT patient_id, count(*) as nums
         FROM public.patient_procedure
         GROUP BY patient_id
     ) as tmp
    WHERE id = patient_id;

ALTER TABLE public.patient
    ALTER COLUMN n_procedures SET NOT NULL;