/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth > '2016-01-01' AND date_of_birth < '2019-12-31';
SELECT name FROM animals WHERE neutered = true  AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- update the species field to unspecified database transaction
BEGIN;
UPDATE animals 
SET species = 'unspecified';

-- perform a rollback
BEGIN;
UPDATE animals 
SET species = 'unspecified';
ROLLBACK;

-- set species to digimon for all the animals whose names end with mon
BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';

-- set species to pokemon for all animals with no species in the same transaction
BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals 
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';

-- Commit the changes
COMMIT;

-- delete all records inside the animals records
BEGIN;
DELETE FROM animals;

-- rollback;
ROLLBACK;

--- delete all animals born after jan 1st 2022 and create savepoint and set the weight to be former weight multiplied by -1 inside a single transaction 
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT removed_dito;
UPDATE animals
SET weight_kg = -1*weight_kg;

--- update all weights that are negative to be positive
--- commit this transaction 
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT removed_dito;
UPDATE animals
SET weight_kg = -1*weight_kg;
ROLLBACK TO SAVEPOINT removed_dito;
UPDATE animals
SET weight_kg = -1*weight_kg WHERE weight_kg < 0;
COMMIT;

/* Extraction Queries */

-- number of animals in the table
SELECT COUNT(*) FROM animals;

-- number of animals that have never escaped
SELECT AVG(weight_kg) FROM animals WHERE escape_attempts = 0;

-- the average weight of all animals
SELECT AVG(weight_kg) FROM animals;

-- animals that escaped the most, neutered or not neutered animals
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered ORDER BY avg DESC LIMIT 1;

-- minimum and maximum weights for each animal type
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- average number of escape attempts per animal type born between 1990 and 2000
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;
