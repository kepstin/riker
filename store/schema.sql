PRAGMA foreign_keys = ON;

CREATE TABLE artist_type (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER UNIQUE NOT NULL
);

CREATE TABLE country (
	id		INTEGER PRIMARY KEY NOT NULL,
	iso_code	CHARACTER UNIQUE NOT NULL,
	name		CHARACTER NOT NULL
);

CREATE TABLE gender (
	id		INTEGER PRIMARY KEY NOT NULL,
	name		CHARACTER UNIQUE NOT NULL
);

CREATE TABLE artist (
	id		INTEGER PRIMARY KEY NOT NULL,
	gid		CHARACTER UNIQUE NOT NULL,
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
	iso_code_3b	CHARACTER UNIQUE NOT NULL,
	iso_code_2	CHARACTER UNIQUE,
	name		CHARACTER NOT NULL
);

CREATE TABLE script (
	id		INTEGER PRIMARY KEY NOT NULL,
	iso_code	CHARACTER UNIQUE NOT NULL,
	iso_number	CHARACTER NOT NULL,
	name		CHARACTER NOT NULL
);

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
