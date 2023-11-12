SET check_function_bodies = false;
CREATE SCHEMA expenses;
CREATE SCHEMA IF NOT EXISTS hdb_catalog;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';

CREATE TABLE expenses.bac_credomatic (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    commerce text NOT NULL,
    location text NOT NULL,
    card_type text NOT NULL,
    amount double precision NOT NULL,
    card_number text NOT NULL,
    currency text NOT NULL,
    date date
);

ALTER TABLE ONLY expenses.bac_credomatic
    ADD CONSTRAINT bac_credomatic_pkey PRIMARY KEY (id);
