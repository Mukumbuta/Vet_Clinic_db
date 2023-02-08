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


CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY(invoice_id) REFERENCES invoices(id)
);
CREATE TABLE treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR,
  name VARCHAR,
  PRIMARY KEY(id)
);