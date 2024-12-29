SET check_function_bodies = false;
CREATE TYPE public.card_type AS ENUM (
    'AMEX',
    'MASTERCARD',
    'VISA',
    'ATM',
    'TX'
);
CREATE TABLE public.banks (
    id uuid NOT NULL,
    name text NOT NULL,
    location public.geography(Point,4326)
);
CREATE TABLE public.commerces (
    id uuid NOT NULL,
    name text,
    location public.geography(Point,4326)
);
CREATE TABLE public.expenses (
    id uuid NOT NULL,
    currency text NOT NULL,
    commerce_id uuid,
    bank_id uuid,
    amount money NOT NULL,
    card_number text NOT NULL,
    card_type public.card_type NOT NULL,
    purchase_date date NOT NULL
);
ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.commerces
    ADD CONSTRAINT commerces_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES public.banks(id) ON UPDATE CASCADE;
ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_commerce_id_fkey FOREIGN KEY (commerce_id) REFERENCES public.commerces(id) ON UPDATE CASCADE;
