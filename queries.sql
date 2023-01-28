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
