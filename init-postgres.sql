CREATE TABLE personas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  edad INTEGER
);

INSERT INTO personas (nombre, edad) VALUES ('Ana Lopez', 28);