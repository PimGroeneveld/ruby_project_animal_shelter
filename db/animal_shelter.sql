DROP TABLE IF EXISTS animal_shelter;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS pets;

CREATE TABLE pets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  breed VARCHAR(255),
  age INT,
  size VARCHAR(255),
  sex VARCHAR(255),
  admission_date DATE,
  trained BOOLEAN,
  cost INT
);

CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE animal_shelter(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  owner VARCHAR(255),
  till INT,
  owner_id INT REFERENCES owners(id),
  pet_id INT REFERENCES pets(id)
);
