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

 Create a new table called owners 
CREATE TABLE owners(
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY(id)
)

-- Create species table
CREATE TABLE species(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	PRIMARY KEY(id)
)

-- Remove species column from animals table
ALTER TABLE animals
DROP COLUMN species;

-- Add species_id column to the animals table 
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners (id);