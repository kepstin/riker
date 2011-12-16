PRAGMA foreign_keys = ON;

CREATE TABLE riker (
	schema_version	INTEGER NOT NULL
);
INSERT INTO riker (schema_version) VALUES (0); -- Unstable schema version

CREATE TABLE artist_mbid (
	id		INTEGER PRIMARY KEY NOT NULL,
	mbid		CHARACTER UNIQUE NOT NULL,
	artist		INTEGER REFERENCES artist (id) NOT NULL
);

CREATE TABLE artist_type (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER UNIQUE NOT NULL
);
INSERT INTO artist_type (name) VALUES ('Person');
INSERT INTO artist_type (name) VALUES ('Group');
INSERT INTO artist_type (name) VALUES ('Other');

CREATE TABLE country (
	id		INTEGER PRIMARY KEY NOT NULL,
	iso_code	CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL
);
-- MusicBrainz-specific nonstandard country codes; others will be imported automatically.
INSERT INTO country (iso_code, name) VALUES ('AN', 'Netherlands Antilles (historical, 1954-2010)');
INSERT INTO country (iso_code, name) VALUES ('CS', 'Serbia and Montenegro (historical, 2003-2006)');
INSERT INTO country (iso_code, name) VALUES ('SU', 'Soviet Union (historical, 1922-1991)');
INSERT INTO country (iso_code, name) VALUES ('XC', 'Czechoslovakia (historical, 1918-1992)');
INSERT INTO country (iso_code, name) VALUES ('XE', 'Europe');
INSERT INTO country (iso_code, name) VALUES ('XG', 'East Germany (historical, 1949-1990)');
INSERT INTO country (iso_code, name) VALUES ('XW', '[Worldwide]');
INSERT INTO country (iso_code, name) VALUES ('YU', 'Yugoslavia (historical, 1918-2003)');
-- TODO: Find a better way to load countries. For testing, here are the top 10:
INSERT INTO country (iso_code, name) VALUES ('US', 'United States');
INSERT INTO country (iso_code, name) VALUES ('GB', 'United Kingdom');
INSERT INTO country (iso_code, name) VALUES ('DE', 'Germany');
INSERT INTO country (iso_code, name) VALUES ('JA', 'Japan');
INSERT INTO country (iso_code, name) VALUES ('FR', 'France');
INSERT INTO country (iso_code, name) VALUES ('NL', 'Netherlands');
INSERT INTO country (iso_code, name) VALUES ('CA', 'Canada');

CREATE TABLE gender (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER UNIQUE NOT NULL
);
INSERT INTO gender (name) VALUES ('Male');
INSERT INTO gender (name) VALUES ('Female');
INSERT INTO gender (name) VALUES ('Other');

CREATE TABLE artist (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER NOT NULL,
	sort_name	CHARACTER NOT NULL,
	begin_date_year	INTEGER,
	begin_date_month	INTEGER,
	begin_date_day	INTEGER,
	end_date_year	INTEGER,
	end_date_month	INTEGER,
	end_date_day	INTEGER,
	artist_type	INTEGER REFERENCES artist_type (id),
	country		INTEGER REFERENCES country (id),
	gender		INTEGER REFERENCES gender (id),
	disambiguation	CHARACTER,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE artist_credit (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER NOT NULL,
	artist_count	INTEGER NOT NULL,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE artist_credit_name (
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	position	INTEGER NOT NULL,
	artist		INTEGER REFERENCES artist (id) NOT NULL,
	name		CHARACTER NOT NULL,
	join_phrase	CHARACTER,
	PRIMARY KEY (artist_credit, position)
);

CREATE TABLE recording (
	id		INTEGER PRIMARY KEY NOT NULL,
	gid		CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL,
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	length		INTEGER CHECK (length IS NULL OR length > 0),
	disambiguation	CHARACTER,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE release_group_type (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER NOT NULL
);

CREATE TABLE release_group (
	id		INTEGER PRIMARY KEY NOT NULL,
	gid		CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL,
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	release_group_type	INTEGER REFERENCES release_group_type (id),
	disambiguation	CHARACTER,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE language (
	id		INTEGER PRIMARY KEY NOT NULL,
	iso_code_3t	CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL
);
INSERT INTO language (iso_code_3t, name) VALUES ('art', '[Artificial (Other)]');
INSERT INTO language (iso_code_3t, name) VALUES ('mul', '[Multiple languages]');
-- TODO: Find a better way to load languages. For testing, here are the top 10:
INSERT INTO language (iso_code_3t, name) VALUES ('eng', 'English');
INSERT INTO language (iso_code_3t, name) VALUES ('jpn', 'Japanese');
INSERT INTO language (iso_code_3t, name) VALUES ('deu', 'German');
INSERT INTO language (iso_code_3t, name) VALUES ('spa', 'Spanish');
INSERT INTO language (iso_code_3t, name) VALUES ('fra', 'French');
INSERT INTO language (iso_code_3t, name) VALUES ('ita', 'Italian');
INSERT INTO language (iso_code_3t, name) VALUES ('por', 'Portuguese');
INSERT INTO language (iso_code_3t, name) VALUES ('fin', 'Finnish');

CREATE TABLE script (
	id		INTEGER PRIMARY KEY NOT NULL,
	iso_code	CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL
);
INSERT INTO script (iso_code, name) VALUES ('Qaaa', '[Multiple scripts]');
-- TODO: Find a better way to load scripts. For testing, here are the top 10:
INSERT INTO script (iso_code, name) VALUES ('Latn', 'Latin');
INSERT INTO script (iso_code, name) VALUES ('Jpan', 'Japanese');
INSERT INTO script (iso_code, name) VALUES ('Cyrl', 'Cyrillic');
INSERT INTO script (iso_code, name) VALUES ('Hant', 'Han (Traditional variant)');
INSERT INTO script (iso_code, name) VALUES ('Grek', 'Greek');
INSERT INTO script (iso_code, name) VALUES ('Kore', 'Korean');
INSERT INTO script (iso_code, name) VALUES ('Hebr', 'Hebrew');
INSERT INTO script (iso_code, name) VALUES ('Hans', 'Han (Simplified variant)');
INSERT INTO script (iso_code, name) VALUES ('Kana', 'Katakana');

CREATE TABLE release_status (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER NOT NULL
);

CREATE TABLE release_packaging (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER NOT NULL
);

CREATE TABLE release (
	id		INTEGER PRIMARY KEY NOT NULL,
	gid		CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL,
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	release_group	INTEGER REFERENCES release_group (id) NOT NULL,
	status		INTEGER REFERENCES release_status (id),
	packaging	INTEGER REFERENCES release_packaging (id),
	country		INTEGER REFERENCES country (id),
	language	INTEGER REFERENCES language (id),
	script		INTEGER REFERENCES script (id),
	date_year	INTEGER,
	date_month	INTEGER,
	date_day	INTEGER,
	barcode		CHARACTER,
	disambiguation	CHARACTER,
	last_update	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE medium_format (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER NOT NULL,
	parent		INTEGER REFERENCES medium_format (id)
);
-- Need to manually specify these to get the tree correct
INSERT INTO medium_format (id, name) VALUES (1, 'CD');
INSERT INTO medium_format (id, name) VALUES (2, 'DVD');
INSERT INTO medium_format (id, name) VALUES (3, 'SACD');
INSERT INTO medium_format (id, name) VALUES (4, 'DualDisc');
INSERT INTO medium_format (id, name) VALUES (6, 'MiniDisc');
INSERT INTO medium_format (id, name) VALUES (7, 'Vinyl');
INSERT INTO medium_format (id, name) VALUES (8, 'Cassette');
INSERT INTO medium_format (id, name) VALUES (12, 'Digital Media');
INSERT INTO medium_format (id, name) VALUES (13, 'Other');
INSERT INTO medium_format (id, name) VALUES (17, 'HD-DVD');
INSERT INTO medium_format (id, name) VALUES (20, 'Blu-ray');
INSERT INTO medium_format (id, name) VALUES (22, 'VCD');
INSERT INTO medium_format (id, name) VALUES (28, 'UMD');
INSERT INTO medium_format (id, name) VALUES (32, 'Videotape');
INSERT INTO medium_format (id, name, parent) VALUES (5, 'LaserDisc', 13);
INSERT INTO medium_format (id, name, parent) VALUES (9, 'Cartridge', 13);
INSERT INTO medium_format (id, name, parent) VALUES (10, 'Reel-to-reel', 13);
INSERT INTO medium_format (id, name, parent) VALUES (11, 'DAT', 13);
INSERT INTO medium_format (id, name, parent) VALUES (14, 'Wax Cylinder', 13);
INSERT INTO medium_format (id, name, parent) VALUES (15, 'Piano Roll', 13);
INSERT INTO medium_format (id, name, parent) VALUES (16, 'DCC', 13);
INSERT INTO medium_format (id, name, parent) VALUES (21, 'VHS', 32);
INSERT INTO medium_format (id, name, parent) VALUES (23, 'SVCD', 22);
INSERT INTO medium_format (id, name, parent) VALUES (24, 'Betamax', 32);
INSERT INTO medium_format (id, name, parent) VALUES (25, 'HDCD', 1);
INSERT INTO medium_format (id, name, parent) VALUES (29, '7" Vinyl', 7);
INSERT INTO medium_format (id, name, parent) VALUES (30, '10" Vinyl', 7);
INSERT INTO medium_format (id, name, parent) VALUES (31, '12" Vinyl', 7);
INSERT INTO medium_format (id, name, parent) VALUES (26, 'USB Flash Drive', 12);
INSERT INTO medium_format (id, name, parent) VALUES (27, 'slotMusic', 12);
INSERT INTO medium_format (id, name, parent) VALUES (18, 'DVD-Audio', 2);
INSERT INTO medium_format (id, name, parent) VALUES (19, 'DVD-Video', 2);
INSERT INTO medium_format (id, name, parent) VALUES (33, 'CD-R', 1);
INSERT INTO medium_format (id, name, parent) VALUES (34, '8cm CD', 1);


CREATE TABLE medium (
	id		INTEGER PRIMARY KEY NOT NULL,
	release		INTEGER REFERENCES release (id) NOT NULL,
	position	INTEGER NOT NULL,
	track_count	INTEGER NOT NULL,
	medium_format	INTEGER REFERENCES medium_format (id) NOT NULL,
	name		CHARACTER,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE track (
	id		INTEGER PRIMARY KEY NOT NULL,
	recording	INTEGER REFERENCES recording (id) NOT NULL,
	medium		INTEGER REFERENCES medium (id) NOT NULL,
	position	INTEGER NOT NULL,
	name		CHARACTER NOT NULL,
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	length		INTEGER CHECK (length IS NULL OR length > 0),
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE file (
	id		INTEGER PRIMARY KEY NOT NULL,
	track		INTEGER REFERENCES track (id),
	recording	INTEGER REFERENCES recording (id) NOT NULL,
	release		INTEGER REFERENCES release (id),
	track_position	INTEGER NOT NULL,
	medium_position	INTEGER NOT NULL,
	codec		CHARACTER,
	bitrate		INTEGER,
	uri		CHARACTER UNIQUE NOT NULL,
	weight		INTEGER NOT NULL,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
