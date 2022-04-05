-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public.room | type: TABLE --
-- DROP TABLE IF EXISTS public.room CASCADE;
CREATE TABLE public.room (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	number varchar(50) NOT NULL,
	capacity smallint NOT NULL,
	CONSTRAINT room_capacity_constraint CHECK (capacity > 0),
	CONSTRAINT room_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.room OWNER TO postgres;
-- ddl-end --

-- object: public.patient | type: TABLE --
-- DROP TABLE IF EXISTS public.patient CASCADE;
CREATE TABLE public.patient (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	room_id bigint NOT NULL,
	name varchar(50) NOT NULL,
	surname varchar(50) NOT NULL,
	patronymic varchar(50),
	birthday date NOT NULL,
	CONSTRAINT patient_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.patient OWNER TO postgres;
-- ddl-end --

-- object: public.medical_procedure | type: TABLE --
-- DROP TABLE IF EXISTS public.medical_procedure CASCADE;
CREATE TABLE public.medical_procedure (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar(256) NOT NULL,
	description text,
	CONSTRAINT procedure_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.medical_procedure OWNER TO postgres;
-- ddl-end --

-- object: public.many_medical_procedure_has_many_room | type: TABLE --
-- DROP TABLE IF EXISTS public.many_medical_procedure_has_many_room CASCADE;
CREATE TABLE public.many_medical_procedure_has_many_room (
	id_medical_procedure bigint NOT NULL,
	id_room bigint NOT NULL,
	CONSTRAINT many_medical_procedure_has_many_room_pk PRIMARY KEY (id_medical_procedure,id_room)
);
-- ddl-end --

-- object: medical_procedure_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_medical_procedure_has_many_room DROP CONSTRAINT IF EXISTS medical_procedure_fk CASCADE;
ALTER TABLE public.many_medical_procedure_has_many_room ADD CONSTRAINT medical_procedure_fk FOREIGN KEY (id_medical_procedure)
REFERENCES public.medical_procedure (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: room_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_medical_procedure_has_many_room DROP CONSTRAINT IF EXISTS room_fk CASCADE;
ALTER TABLE public.many_medical_procedure_has_many_room ADD CONSTRAINT room_fk FOREIGN KEY (id_room)
REFERENCES public.room (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: patient_fk_room_id | type: CONSTRAINT --
-- ALTER TABLE public.patient DROP CONSTRAINT IF EXISTS patient_fk_room_id CASCADE;
ALTER TABLE public.patient ADD CONSTRAINT patient_fk_room_id FOREIGN KEY (room_id)
REFERENCES public.room (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


