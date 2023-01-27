/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE SEQUENCE mytable_id_seq START 100;

CREATE TABLE animals (
    id INTEGER NOT NULL DEFAULT nextval('mytable_id_seq'),
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id)
);

