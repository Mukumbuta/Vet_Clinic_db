/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth > '2016-01-01' AND date_of_birth < '2019-12-31';
SELECT name FROM animals WHERE neutered = true  AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Fetch animals that belong to Melody pond
SELECT name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- Fetch animals that are pokemon 
SELECT animals.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- Get all owners and their animals
SELECT species.name, COUNT(species.name)
FROM animals 
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- Get all digimon owned by Jennifer Orwell
SELECT animals_species.name
FROM (
	SELECT animals.id, animals.name, animals.owner_id 
	FROM animals
	INNER JOIN species 
	ON animals.species_id = species.id
	WHERE species.name = 'Digimon'
) as animals_species
INNER JOIN owners
ON animals_species.owner_id = owners.id
WHERE owners.full_name = 'Jenifer Orwell';

-- Get all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name
FROM animals
INNER JOIN owners
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' 
AND escape_attempts = 0;

-- FInd the person who owns the most animals
SELECT owners.full_name, COUNT(animals.name)
FROM owners 
INNER JOIN animals
ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY count DESC
LIMIT 1;


* --------------QUERIES TO DO WITH MULTIPLE TABLES ---------------------------------*/
-- the last animal seen by William Tatcher
SELECT name
FROM animals
WHERE id = (
	SELECT animal_id FROM visits 
	WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
	ORDER BY date_of_visit DESC
	LIMIT 1
);

-- the different animals Stephanie Mendez saw
SELECT DISTINCT COUNT(*) FROM visits 
	WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')

-- all vets and their specialties, including vets with no specialties
SELECT vet_spec.name AS vet_name, species.name AS species_name
FROM (
	SELECT DISTINCT vets.name, spe.species_id 
	FROM vets 
	LEFT JOIN specializations AS spe
	ON spe.vet_id = vets.id
) AS vet_spec
FULL JOIN species
ON vet_spec.species_id = species.id
ORDER BY vet_name;

-- all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, by_steph.date_of_visit
FROM animals
INNER JOIN (
	SELECT * 
	FROM visits
	WHERE vet_id = (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez')
	AND (date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30')
) AS by_steph
ON by_steph.animal_id = animals.id;

-- animals that have the most visits to vets
SELECT name 
FROM animals
INNER JOIN (
	SELECT animal_id, COUNT(*) 
	FROM visits 
	GROUP BY animal_id
	ORDER BY count DESC
	LIMIT 1
) as most_visits
ON animals.id = most_visits.animal_id;

-- Maisy Smith's first visit
SELECT name 
FROM animals
WHERE animals.id = (
	SELECT animal_id
	FROM visits 
	WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Maisy Smith')
	ORDER BY date_of_visit ASC
	LIMIT 1
)

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT minus_vet_info.name AS animal_name, minus_vet_info.date_of_birth as animal_date_of_birth, escape_attempts, 
neutered, weight_kg, species_id, owner_id, animal_id vet_id ,date_of_visit, vets.name as vet_name,
vets.age as vet_age, date_of_graduation as vet_day_of_graduation
FROM (
	SELECT *
	FROM animals
	INNER JOIN (
		SELECT * 
		FROM visits 
		ORDER BY visits.date_of_visit DESC
		LIMIT 1
	) AS latest
	ON latest.animal_id = animals.id
)  AS minus_vet_info
INNER JOIN vets
ON minus_vet_info.vet_id = vets.id;

-- Get the number of  visits for unspecialized 
SELECT COUNT(*) 
FROM visits 
WHERE (
	SELECT id
	FROM  vets
	LEFT JOIN specializations AS sp
	ON vets.id = sp.vet_id
	where sp.species_id IS NULL
) = visits.vet_id;

SELECT name 
FROM species
WHERE 
species.id = (
	SELECT species_id
	FROM animals
	INNER JOIN (
		SELECT animal_id, COUNT(*) 
		FROM visits 
		WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Maisy Smith')
		GROUP BY animal_id
		ORDER BY count DESC
		LIMIT 1
	) AS s_v
	ON s_v.animal_id = animals.id
);

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


