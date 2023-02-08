CREATE TABLE patients(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
  date_of_birth DATE,
	PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at timestamp,
  patient_id INT,
  status VARCHAR,
  PRIMARY KEY(id),
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS as IDENTITY,
  total_amount DECIMAL,
  generate_at timestamp,
  payed_at timestamp,
  medical_history_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY (medical_history_id ) REFERENCES medical_histories(id)
);
