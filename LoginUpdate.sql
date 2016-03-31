CREATE EXTENSION pgcrypto;
ALTER TABLE login ALTER COLUMN password TYPE text;
GRANT UPDATE ON login_id_seq TO visiting;

