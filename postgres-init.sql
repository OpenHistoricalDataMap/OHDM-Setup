--CREATE EXTENSION postgis;
CREATE EXTENSION hstore;
CREATE SCHEMA intermediate;
CREATE SCHEMA ohdm;
CREATE SCHEMA rendering;
CREATE SCHEMA mapnik;
CREATE USER mapnik WITH ENCRYPTED PASSWORD 'mapnik';
GRANT ALL PRIVILEGES ON DATABASE testgis TO mapnik;
GRANT ALL PRIVILEGES ON SCHEMA intermediate TO mapnik;
GRANT ALL PRIVILEGES ON SCHEMA ohdm TO mapnik;
GRANT ALL PRIVILEGES ON SCHEMA rendering TO mapnik;
GRANT ALL PRIVILEGES ON SCHEMA mapnik TO mapnik;