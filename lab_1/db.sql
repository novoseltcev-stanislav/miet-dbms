CREATE DATABASE miet_lab1;


CREATE TABLE public.items (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	order_id bigint,
	part_id bigint,
	quantity bigint NOT NULL,
	discount jsonb,
	CONSTRAINT items_pk_id PRIMARY KEY (id)
);
ALTER TABLE public.items OWNER TO postgres;


CREATE TABLE public.parts (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	vendor_id bigint,
	description varchar(300) NOT NULL,
	on_hand bigint NOT NULL,
	on_order bigint NOT NULL,
	cost money NOT NULL,
	list_price money NOT NULL,
	CONSTRAINT parts_pk_id PRIMARY KEY (id)
);
COMMENT ON COLUMN public.parts.cost IS E'за сколько купили у поставщика';
COMMENT ON COLUMN public.parts.list_price IS E'за сколько продаём';
ALTER TABLE public.parts OWNER TO postgres;


CREATE TABLE public.vendors (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	address_id bigint,
	phone_id bigint,
	fax_id bigint,
	name character varying(100),
	preferred bool NOT NULL DEFAULT false,
	CONSTRAINT vendors_pk_id PRIMARY KEY (id)
);
COMMENT ON COLUMN public.vendors.preferred IS E'если есть опция купить у этого поставщика, покупаем у него';
ALTER TABLE public.vendors OWNER TO postgres;


CREATE TABLE public.phones (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	phone varchar(32) NOT NULL,
	CONSTRAINT phones_pk_id PRIMARY KEY (id)
);
ALTER TABLE public.phones OWNER TO postgres;


CREATE TABLE public.faxes (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	fax character varying(100) NOT NULL,
	CONSTRAINT faxes_pk_id PRIMARY KEY (id)
);
ALTER TABLE public.faxes OWNER TO postgres;


CREATE TABLE public.addresses (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	billing_address character varying(200),
	shipping_address character varying(200),
	city character varying(60) NOT NULL,
	zip character varying(20) NOT NULL,
	country character varying(2) NOT NULL,
	CONSTRAINT addresses_pk_id PRIMARY KEY (id)
);
COMMENT ON COLUMN public.addresses.country IS E'ISO 3166-1 alpha-2';
ALTER TABLE public.addresses OWNER TO postgres;


CREATE TABLE public.customers (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
    company VARCHAR(100) NOT NULL,
    address_id bigint,
	fax_id bigint,
	phone_id smallint,
	tax_rate float NOT NULL,
	contact jsonb NOT NULL,
	last_invoice_date date,
	CONSTRAINT customers_pk_id PRIMARY KEY (id)
);
ALTER TABLE public.customers OWNER TO postgres;


CREATE TABLE public.employees (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	first_name character varying(50) NOT NULL,
	last_name character varying(50) NOT NULL,
	hire_date date NOT NULL,
	salary money NOT NULL,
	CONSTRAINT employees_pk_id PRIMARY KEY (id)
);
ALTER TABLE public.employees OWNER TO postgres;


CREATE TABLE public.orders (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	customer_id bigint,
	address_id bigint,
	employee_id bigint,
	payment_method jsonb NOT NULL,
	items_total smallint NOT NULL,
	tax_rate float NOT NULL,
	freight jsonb NOT NULL,
	amount_paid money,
	created_at date NOT NULL,
	shipped_at date,
	CONSTRAINT orderds_pk_id PRIMARY KEY (id)
);
ALTER TABLE public.orders OWNER TO postgres;


ALTER TABLE public.items ADD CONSTRAINT items_fk_part_id FOREIGN KEY (part_id)
REFERENCES public.parts (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.items ADD CONSTRAINT items_fk_order_id FOREIGN KEY (order_id)
REFERENCES public.orders (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.parts ADD CONSTRAINT parts_fk_vendor_id FOREIGN KEY (vendor_id)
REFERENCES public.vendors (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.vendors ADD CONSTRAINT vendors_fk_phone_id FOREIGN KEY (phone_id)
REFERENCES public.phones (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.vendors ADD CONSTRAINT vendors_fk_fax_id FOREIGN KEY (fax_id)
REFERENCES public.faxes (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.vendors ADD CONSTRAINT vendors_fk_address_id FOREIGN KEY (address_id)
REFERENCES public.addresses (id) MATCH SIMPLE
ON DELETE cascade ON UPDATE NO ACTION;

ALTER TABLE public.customers ADD CONSTRAINT customers_fk_address_id FOREIGN KEY (address_id)
REFERENCES public.addresses (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.customers ADD CONSTRAINT customers_fk_fax_id FOREIGN KEY (fax_id)
REFERENCES public.faxes (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.customers ADD CONSTRAINT customers_fk_phone_id FOREIGN KEY (phone_id)
REFERENCES public.phones (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.orders ADD CONSTRAINT orders_fk_customer_id FOREIGN KEY (customer_id)
REFERENCES public.customers (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.orders ADD CONSTRAINT orderrs_fk_address_id FOREIGN KEY (address_id)
REFERENCES public.addresses (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE public.orders ADD CONSTRAINT orderrs_fk_employee_id FOREIGN KEY (employee_id)
REFERENCES public.employees (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
