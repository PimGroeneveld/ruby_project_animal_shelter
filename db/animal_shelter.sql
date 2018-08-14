DROP TABLE IF EXISTS adoptions;
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
  adoptable BOOLEAN,
  cost INT,
  picture VARCHAR(255)
);

CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE adoptions(
  id SERIAL PRIMARY KEY,
  owner_id INT REFERENCES owners(id) ON DELETE CASCADE,
  pet_id INT REFERENCES pets(id) ON DELETE CASCADE
);
