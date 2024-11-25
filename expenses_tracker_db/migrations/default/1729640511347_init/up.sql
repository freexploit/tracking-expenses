CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;

CREATE TYPE card_type AS ENUM ('AMEX', 'MASTERCARD', 'VISA', 'ATM', 'TX');

CREATE TABLE commerces (
    id UUID NOT NULL,
    name TEXT,
    location GEOGRAPHY(Point),
    PRIMARY KEY(id)
);

CREATE TABLE banks (
    id UUID NOT NULL,
    name TEXT NOT NULL,
    location GEOGRAPHY(Point),
    PRIMARY KEY(id)
);

CREATE TABLE expenses (
    id uuid NOT NULL, 
    currency text NOT NULL,
    commerce_id uuid NOT NULL REFERENCES commerces(id) on update cascade,
    bank_id uuid NOT NULL REFERENCES banks(id) on update cascade,
    amount money NOT NULL,
    location text NOT NULL,
    card_number text NOT NULL,
    card_type card_type NOT NULL,
    purchase_date date NOT NULL,
    PRIMARY KEY (id)
);
