CREATE TABLE track (
	id		INTEGER PRIMARY KEY,
	recording	INTEGER,
	tracklist	INTEGER,
	position	INTEGER NOT NULL,
	name		INTEGER,
	artist_credit	INTEGER,
	length		INTEGER,
	last_updated	TIMESTAMP NOT NULL
);

CREATE TABLE file (
	id		INTEGER PRIMARY KEY,
	track		INTEGER REFERENCES track(id) NOT NULL,
	uri		VARCHAR NOT NULL
);
