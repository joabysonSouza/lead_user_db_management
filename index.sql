CREATE Table usuario (
    id SERIAL PRIMARY KEY,
    email_usuario VARCHAR(50) NOT NULL UNIQUE,
    cpf VARCHAR(11) NOT NULL UNIQUE CONSTRAINT check_cpf CHECK (
        CHAR_LENGTH(cpf) = 11
        AND cpf ~ '^[0-9]+$'
    )
);




CREATE TABLE lead(
    id SERIAL PRIMARY KEY,
    email_lead VARCHAR(50) NOT NULL ,
    data TIMESTAMP DEFAULT NOW()
);


CREATE TABLE notificacao_lead (
    id SERIAL PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    data_insercao TIMESTAMP DEFAULT NOW(),
    data_disparo TIMESTAMP
);

CREATE OR REPLACE FUNCTION check_lead()
  RETURNS TRIGGER AS $$
  BEGIN
  IF EXISTS (SELECT 1 FROM usuario WHERE email_usuario = NEW.email_lead) THEN RAISE EXCEPTION 'esse lead já é usuario';
  ELSE
  INSERT INTO notificacao_lead(email)VALUES(NEW.email_lead);
  END IF;
  RETURN NEW;
  END;
  $$ LANGUAGE PLPGSQL;

CREATE Trigger trigger_check_lead
AFTER INSERT ON lead FOR EACH ROW
EXECUTE FUNCTION check_lead ();

SELECT * FROM usuario;

SELECT * FROM lead;

SELECT * from notificacao_lead;

SELECT * FROM usuario;

SELECT * FROM lead;

