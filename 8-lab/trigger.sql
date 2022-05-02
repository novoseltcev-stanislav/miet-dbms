CREATE OR REPLACE FUNCTION inc_patient_procedure() RETURNS trigger AS $$
    BEGIN
        UPDATE public.patient
            SET n_procedures = n_procedures + 1
            WHERE id = NEW.patient_id;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_add_procedure_to_patient
    AFTER INSERT ON public.patient_procedure
    FOR EACH ROW EXECUTE FUNCTION inc_patient_procedure();


CREATE OR REPLACE FUNCTION dec_patient_procedure() RETURNS trigger AS $$
    BEGIN
        UPDATE public.patient
            SET n_procedures = n_procedures - 1
            WHERE id = OLD.patient_id;
        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_delete_procedure_from_patient
    AFTER DELETE ON public.patient_procedure
    FOR EACH ROW EXECUTE FUNCTION dec_patient_procedure();

CREATE OR REPLACE FUNCTION delete_patient_procedures() RETURNS trigger AS $$
    BEGIN
        DELETE FROM patient_procedure
            WHERE patient_id = OLD.id;
        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_delete_patient
    AFTER DELETE ON public.patient
    FOR EACH ROW EXECUTE FUNCTION delete_patient_procedures();