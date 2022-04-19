CREATE TABLE public.room (
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    number varchar(32) NOT NULL,
    capacity smallint CHECK (capacity > 0),

    CONSTRAINT room_pk PRIMARY KEY (id)
);

CREATE TABLE public.patient (
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    room_id bigint not null,
    name varchar(50) not null,
    surname varchar(50) not null,
    patronymic varchar(50) null,
    birthday date not null,
    
    CONSTRAINT patient_pk PRIMARY KEY (id),
    CONSTRAINT patient_fk_room_id FOREIGN KEY (room_id) 
        REFERENCES public.room (id) MATCH SIMPLE 
            ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE public.medical_procedure (
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(256) NOT NULL,
    description TEXT NULL,

    CONSTRAINT medical_procedure_pk PRIMARY KEY (id)
);

CREATE TABLE public.patient_procedure (
    patient_id bigint NOT NULL,
    medical_procedure_id bigint NOT NULL,
    duration interval NULL,
    assigned_quantity smallint NOT NULL CHECK (assigned_quantity > 0),
    completed_quantity smallint NOT NULL DEFAULT 0 CHECK (completed_quantity >= 0),

    CONSTRAINT patient_procedure_pk PRIMARY KEY (patient_id, medical_procedure_id),
    CONSTRAINT patient_procedure_fk_patient_id FOREIGN KEY (patient_id)
       REFERENCES public.patient (id) MATCH SIMPLE
           ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT patient_procedure_fk_m_p_id FOREIGN KEY (medical_procedure_id)
       REFERENCES public.medical_procedure (id) MATCH SIMPLE
           ON DELETE NO ACTION ON UPDATE NO ACTION

);
