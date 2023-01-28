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

-- MORE TABLES
CREATE TABLE owners(
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY(id)
)

CREATE TABLE species(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	PRIMARY KEY(id)
)

ALTER TABLE animals
DROP COLUMN species;

-- Add species_id column to the animals table 
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners (id);

ADD COLUMN owner_id INT REFERENCES owners (id);

/* Join tables for visits */

CREATE TABLE vets(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
)

CREATE TABLE specializations(
	vet_id INT REFERENCES vets(id),
	species_id INT REFERENCES species(id)
)

CREATE TABLE visits(
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
);
