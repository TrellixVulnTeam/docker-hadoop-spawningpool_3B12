CREATE USER {{hue["db-user"]}} WITH PASSWORD '{{hue["db-password"]}}';
CREATE DATABASE hue OWNER {{hue["db-user"]}};
GRANT ALL PRIVILEGES ON DATABASE {{hue["db-name"]}} TO hue["db-user"];
