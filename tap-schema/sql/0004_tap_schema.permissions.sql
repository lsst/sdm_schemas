
-- grant usage on schema tap_schema to ''@'%';

GRANT SELECT ON tap_schema.* TO 'TAP_SCHEMA'@'%';
FLUSH PRIVILEGES;

ALTER USER 'TAP_SCHEMA'@'%' IDENTIFIED WITH mysql_native_password BY 'TAP_SCHEMA';
