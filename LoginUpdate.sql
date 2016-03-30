CREATE EXTENSION pgcrypto;
ALTER TABLE login ALTER COLUMN password TYPE text;
INSERT INTO login (first_name, last_name, username, password) VALUES ('Hasan', 'Shami', 'hshami', crypt('toilet', gen_salt('bf')));

