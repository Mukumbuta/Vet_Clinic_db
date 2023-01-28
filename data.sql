/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8.00);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11.00);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

-- insert values into the owners table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jenifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- insert data into teh species table
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- animal according to species_id 
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

UPDATE animals
SET owner_id = (SELECT id FROM ownersWHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jenifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon';


HERE name = 'Angemon' OR name = 'Boarmon';

/* INSERT DATA INTO NEWLY CREATED TABLES  */

-- adds data to the vets table
INSERT INTO vets
	(name, age, date_of_graduation)
VALUES
	('William Tatcher', 45, '2000-04-23'),
	('Maisy Smith', 26, '2019-01-17'),
	('Stephanie Mendez', 64, '1981-05-04'),
	('Jack Harkness', 38, '2008-06-08');

-- inserting data for the different specialities
INSERT INTO specializations (vet_id, species_id)
VALUES
	((SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
	(SELECT id FROM species WHERE species.name = 'Pokemon')),
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
	(SELECT id FROM species WHERE species.name = 'Pokemon')),
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
	(SELECT id FROM species WHERE species.name = 'Digimon')),
	((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
	(SELECT id FROM species WHERE species.name = 'Digimon'));

SELECT * FROM specializations;

-- insert visitation data
INSERT INTO visits (vet_id, animal_id)
VALUES
	((SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
	(SELECT id FROM animals WHERE animals.name = 'Agumon'),
	('2020-07-24')
	),
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
	(SELECT id FROM animals WHERE animals.name = 'Agumon'),
	('2020-07-22')
	),
	((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
	(SELECT id FROM animals WHERE animals.name = 'Gabumon'),
	('2021-02-02')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Pikachu'),
	('2020-01-05')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Pikachu'),
	('2020-03-08')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Pikachu'),
	('2020-05-14')
	),
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
	(SELECT id FROM animals WHERE animals.name = 'Devimon'),
	('2021-05-04')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Plantmon'),
	('2019-12-21')
	),
	((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
	(SELECT id FROM animals WHERE animals.name = 'Charmander'),
	('2021-02-24')
	),
	((SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
	(SELECT id FROM animals WHERE animals.name = 'Plantmon'),
	('2020-08-10')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Plantmon'),
	('2021-04-07')
	),
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
	(SELECT id FROM animals WHERE animals.name = 'Squirtle'),
	('2019-09-29')
	),
	((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
	(SELECT id FROM animals WHERE animals.name = 'Angemon'),
	('2020-10-03')
	),
	((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
	(SELECT id FROM animals WHERE animals.name = 'Angemon'),
	('2020-11-04')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Boarmon'),
	('2019-01-24')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Boarmon'),
	('2019-05-15')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Boarmon'),
	('2019-02-27')
	),
	((SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
	(SELECT id FROM animals WHERE animals.name = 'Boarmon'),
	('2019-08-03')
	),
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
	(SELECT id FROM animals WHERE animals.name = 'Blossom'),
	('2020-05-24')
	),
	((SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
	(SELECT id FROM animals WHERE animals.name = 'Blossom'),
	('2021-01-11')
	);

    