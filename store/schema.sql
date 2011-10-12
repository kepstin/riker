CREATE TABLE IF NOT EXISTS artist_type (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		VARCHAR UNIQUE NOT NULL
);

INSERT OR IGNORE INTO artist_type (id, name) VALUES (1, 'Person');
INSERT OR IGNORE INTO artist_type (id, name) VALUES (2, 'Group');
INSERT OR IGNORE INTO artist_type (id, name) VALUES (3, 'Other');

CREATE TABLE IF NOT EXISTS country (
	id		INTEGER PRIMARY KEY NOT NULL,
	iso_code	VARCHAR	UNIQUE NOT NULL,
	name		VARCHAR NOT NULL
);

INSERT OR IGNORE INTO country (id, iso_code, name) VALUES (107, 'JP', 'Japan');

CREATE TABLE IF NOT EXISTS gender (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		VARCHAR UNIQUE NOT NULL
);

INSERT OR IGNORE INTO gender (id, name) values (1, 'Male');
INSERT OR IGNORE INTO gender (id, name) values (2, 'Female');
INSERT OR IGNORE INTO gender (id, name) values (3, 'Other');

CREATE TABLE IF NOT EXISTS artist (
	id		INTEGER PRIMARY KEY NOT NULL,
	gid		VARCHAR UNIQUE NOT NULL,
	name		VARCHAR NOT NULL,
	sort_name	VARCHAR NOT NULL,
	begin_date_year	INTEGER,
	begin_date_month	INTEGER,
	begin_date_day	INTEGER,
	end_date_year	INTEGER,
	end_date_month	INTEGER,
	end_date_day	INTEGER,
	artist_type	INTEGER REFERENCES artist_type (id),
	country		INTEGER REFERENCES country (id),
	gender		INTEGER REFERENCES gender (id),
	comment		VARCHAR,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT OR IGNORE INTO artist (id, gid, name, sort_name, artist_type, country) VALUES (1, 'e1719c24-118e-425b-8f94-954dcf583fb0', '40mP', '40mP', (SELECT id FROM artist_type WHERE name = 'Person'), (SELECT id FROM country WHERE iso_code = 'JP'));
INSERT OR IGNORE INTO artist (id, gid, name, sort_name, begin_date_year, begin_date_month, begin_date_day, artist_type, gender) VALUES (2, '130d679a-9a92-4373-8348-0800b6b93a30', '初音ミク', 'Hatsune, Miku', 2007, 8, 31, (SELECT id FROM artist_type WHERE name = 'Other'), (SELECT id FROM gender WHERE name = 'Female'));
INSERT OR IGNORE INTO artist (id, gid, name, sort_name, artist_type, gender, comment) VALUES (3, 'ef46bbef-dba2-46e3-b534-1b44cbddf249', 'GUMI', 'GUMI', (SELECT id FROM artist_type WHERE name = 'Other'), (SELECT id FROM gender WHERE name = 'Female'), 'vocaloid');
INSERT OR IGNORE INTO artist (id, gid, name, sort_name, artist_type, country) VALUES (4, '623ea50d-00c2-4576-8303-db088e84951d', '1640mP', '1640mP', (SELECT id FROM artist_type WHERE name = 'Group'), (SELECT id FROM country WHERE iso_code = 'JP'));

CREATE TABLE IF NOT EXISTS artist_credit (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		VARCHAR NOT NULL,
	artist_count	INTEGER NOT NULL,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (1, '40mP', 1);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (2, '40mP feat. 初音ミク', 2);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (3, '40mP feat. GUMI', 2);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (4, '1640mP feat. 初音ミク', 2);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (5, '40mP feat. 初音ミク・GUMI', 3);

CREATE TABLE IF NOT EXISTS artist_credit_name (
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	position	INTEGER NOT NULL,
	artist		INTEGER REFERENCES artist (id) NOT NULL,
	name		VARCHAR NOT NULL,
	join_phrase	VARCHAR,
	PRIMARY KEY (artist_credit, position)
);

INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (1, 1, 1, '40mP', NULL);
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (2, 1, 1, '40mP', ' feat. ');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (2, 2, 2, '初音ミク', NULL);
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (3, 1, 1, '40mP', ' feat. ');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (3, 2, 3, 'GUMI', NULL);

CREATE TABLE IF NOT EXISTS file (
	id		INTEGER PRIMARY KEY NOT NULL,
	track		INTEGER REFERENCES track (id) NOT NULL,
	uri		VARCHAR NOT NULL,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recording (
	id		INTEGER PRIMARY KEY NOT NULL,
	gid		VARCHAR UNIQUE NOT NULL,
	name		VARCHAR NOT NULL,
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	length		INTEGER CHECK (length IS NULL OR length > 0),
	comment		VARCHAR,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS track (
	id		INTEGER PRIMARY KEY NOT NULL,
	recording	INTEGER REFERENCES recording (id) NOT NULL,
	tracklist	INTEGER REFERENCES tracklist (id) NOT NULL,
	position	INTEGER NOT NULL,
	name		VARCHAR NOT NULL,
	artist_credit	INTEGER REFERENCES artist_credit (id) NOT NULL,
	length		INTEGER CHECK (length IS NULL OR length > 0),
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tracklist (
	id		INTEGER PRIMARY KEY NOT NULL,
	track_count	INTEGER NOT NULL,
	last_updated	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT OR IGNORE INTO tracklist (id, track_count) VALUES (1, 16);
