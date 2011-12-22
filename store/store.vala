/*
 * Riker - a MusicBrainz-enhanced audio player
 * Copyright © 2011 Calvin Walton
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

namespace Riker {

/**
 * Various errors that can happen due to database interactions.
 */
public errordomain StoreError {
	OPEN_FAILED,
	UNSUPPORTED_SCHEMA,
	CORRUPT_DB,
	INSTALLATION_ERROR,
	BUG
}

/**
 * The store represents the database backend where information is stored.
 */
public class Store: Object {
	
	/**
	 * The database schema version supported by this version of Riker.
	 *
	 * If this is 0, then Riker is using an unstable schema.
	 */
	private const int SCHEMA_VERSION = 0;

	/**
	 * The oldest database schema version supported for upgrades.
	 */
	private const int MIN_SCHEMA_VERSION = 1;

	/**
	 * The newest schema version supported for upgrades.
	 *
	 * This is normally set to SCHEMA_VERSION - 1, unless SCHEMA_VERSION
	 * is 0
	 */
	private const int MAX_SCHEMA_VERSION = 1;

	/**
	 * The location of the database file
	 */
	public string path {
		get;
		construct;
	}

	/**
	 * The Sqlite database instance.
	 */
	private Sqlite.Database db;

	/**
	 * Create a new Store instance using the default database location.
	 *
	 * This is normally in a ~/.local/share/riker/store.db, but varies by
	 * platform.
	 */
	public Store() {
		Object(path: Path.build_filename(Environment.get_user_data_dir(), "riker", "store.db"));
	}

	/**
	 * Create a Store instance using a non-standard database location.
	 */
	public Store.from_path(string path) {
		Object(path: path);
	}

	/**
	 * Open the database, and prepare it for use.
	 *
	 * This function will create the database if it doesn't exist,
	 * initialize the schema, and perform any appropriate upgrades.
	 *
	 * @throws StoreError The database could not be initialized. The error
	 *         type and message will provide details. If this error is
	 *         given, the Store object must not be used.
	 */
	public void open() throws StoreError {
		/* A few helpful warnings for testers... */
		if (SCHEMA_VERSION == 0) {
			stderr.printf(
"This version of Riker uses an unstable database schema. If you update Riker\n" +
"you must delete the database file and either restore a backup from an older\n" +
"stable version or rescan your music collection.\n");
		}
		stderr.printf("Database location: %s\n", path);

		/*
		 * Check whether the database is already present (do we have
		 * to initialize the schema?)
		 */
		bool existing_db;
		if (FileUtils.test(path, FileTest.IS_REGULAR)) {
			stderr.printf("Database already exists, attempting to open it.\n");
			existing_db = true;
		} else {
			stderr.printf("Database does not exist, creating a new one.\n");
			existing_db = false;
			/* If the database files doesn't exist, the folder might not either */
			DirUtils.create_with_parents(Path.get_dirname(path), 0700);
		}
		
		/*
		 * Open the database file. This will create it if it doesn't
		 * already exist.
		 */
		var rc = Sqlite.Database.open(path, out db);
		if (rc != Sqlite.OK) {
			throw new StoreError.OPEN_FAILED("Could not open database: " + db.errmsg());
		}
		stderr.printf("Database opened.\n");

		/* If it's a new database, load the schema */
		if (!existing_db) {
			load_schema();
		}

		/* Query the database for its schema version */
		Sqlite.Statement stmt;
		var query = "SELECT schema_version FROM riker";
		rc = db.prepare_v2(query, query.length, out stmt);
		if (rc != Sqlite.OK) {
			throw new StoreError.CORRUPT_DB("Corrupt database: " + db.errmsg());
		}
		rc = stmt.step();
		if (rc != Sqlite.ROW) {
			if (rc == Sqlite.DONE) {
				throw new StoreError.CORRUPT_DB("Corrupt database: 'riker' table is empty");
			} else {
				throw new StoreError.BUG("BUG: " + db.errmsg());
			}
		}
		int version = stmt.column_int(0);
		if (version == SCHEMA_VERSION) {
			return;
		}

		throw new StoreError.UNSUPPORTED_SCHEMA("Database schema version not supported\n");
	}

	/**
	 * Load the base schema into a fresh database.
	 */
	private void load_schema() throws StoreError {
#if ENABLE_UNINSTALLED
		string schema_path = Path.build_filename(Config.BUILD_SRCDIR, "store", "schema.sql");
#else
		// TODO: Find a better way to define this path.
		string schema_path = Path.build_filename(Config.DATADIR, Config.PACKAGE_TARNAME, "store", "schema.sql");
#endif
		stderr.printf("Loading database schema...\n");
		string query;
		try {
			FileUtils.get_contents(schema_path, out query);
		} catch (FileError e) {
			throw new StoreError.INSTALLATION_ERROR("Failed to read schema: " + e.message);
		}
		
		string errmsg;
		var rc = db.exec(query, null, out errmsg);
		if (rc != Sqlite.OK) {
			if (errmsg != null) {
				throw new StoreError.BUG("BUG: Error loading schema: " + errmsg);
			} else {
				throw new StoreError.BUG("BUG: Error loading schema: " + db.errmsg());
			}
		}
		stderr.printf("Database schema loaded.\n");
	}

	/**
	 * Look up a Country by its row id.
	 *
	 * @param id The ID (row id) of the Country.
	 * @return The Country, or null if not found.
	 */
	public Country? get_country_by_id(int64 id) throws StoreError {
		return Country.from_id(db, id);
	}

	/**
	 * Look up a Country by its ISO code.
	 *
	 * @param iso_code The two-letter ISO code of the Country.
	 * @return The Country, or null if not found.
	 */
	public Country? get_country_by_iso_code(string iso_code) throws StoreError {
		return Country.from_iso_code(db, iso_code);
	}

	/**
	 * Look up an ArtistType by its row id.
	 *
	 * @param id The ID (row id) of the ArtistType.
	 * @return The ArtistType, or null if not found.
	 */
	public ArtistType? get_artist_type_by_id(int id) throws StoreError {
		int rc;
		ArtistType artist_type = null;

		/* Cache the prepared query */
		if (ArtistType.select_by_id_stmt == null) {
			rc = db.prepare_v2(ArtistType.select_by_id, ArtistType.select_by_id.length, out ArtistType.select_by_id_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}

		/* Execute the query */
		ArtistType.select_by_id_stmt.bind_int(1, id);
		while ((rc = ArtistType.select_by_id_stmt.step()) == Sqlite.ROW) {
			artist_type = new ArtistType.from_row(ArtistType.select_by_id_stmt);
		}
		ArtistType.select_by_id_stmt.reset();
		if (rc != Sqlite.DONE) {
			throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
		}
		return artist_type;
	}

	/**
	 * Look up an ArtistType by its name.
	 *
	 * @param name The name of the ArtistType.
	 * @return The ArtistType, or null if not found.
	 */
	public ArtistType? get_artist_type_by_name(string name) throws StoreError {
		int rc;
		ArtistType artist_type = null;

		/* Cache the prepared query */
		if (ArtistType.select_by_name_stmt == null) {
			rc = db.prepare_v2(ArtistType.select_by_name, ArtistType.select_by_name.length, out ArtistType.select_by_name_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}

		/* Execute the query */
		ArtistType.select_by_name_stmt.bind_text(1, name);
		while ((rc = ArtistType.select_by_name_stmt.step()) == Sqlite.ROW) {
			artist_type = new ArtistType.from_row(ArtistType.select_by_name_stmt);
		}
		ArtistType.select_by_name_stmt.reset();
		if (rc != Sqlite.DONE) {
			throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
		}
		return artist_type;
	}

	/**
	 * Look up a Gender by its row id.
	 *
	 * @param id The ID (row id) of the Gender.
	 * @return The Gender, or null if not found.
	 */
	public Gender? get_gender_by_id(int id) throws StoreError {
		int rc;
		Gender gender = null;

		/* Cache the prepared query */
		if (Gender.select_by_id_stmt == null) {
			rc = db.prepare_v2(Gender.select_by_id, Gender.select_by_id.length, out Gender.select_by_id_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}

		/* Execute the query */
		Gender.select_by_id_stmt.bind_int(1, id);
		while ((rc = Gender.select_by_id_stmt.step()) == Sqlite.ROW) {
			gender = new Gender.from_row(Gender.select_by_id_stmt);
		}
		Gender.select_by_id_stmt.reset();
		if (rc != Sqlite.DONE) {
			throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
		}
		return gender;
	}

	/**
	 * Look up a Gender by its name.
	 *
	 * @param name The name of the Gender.
	 * @return The ArtistType, or null if not found.
	 */
	public Gender? get_gender_by_name(string name) throws StoreError {
		int rc;
		Gender gender = null;

		/* Cache the prepared query */
		if (Gender.select_by_name_stmt == null) {
			rc = db.prepare_v2(Gender.select_by_name, Gender.select_by_name.length, out Gender.select_by_name_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}

		/* Execute the query */
		Gender.select_by_name_stmt.bind_text(1, name);
		while ((rc = Gender.select_by_name_stmt.step()) == Sqlite.ROW) {
			gender = new Gender.from_row(Gender.select_by_name_stmt);
		}
		Gender.select_by_name_stmt.reset();
		if (rc != Sqlite.DONE) {
			throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
		}
		return gender;
	}

	/**
	 * Look up a Artist by its MBID.
	 *
	 * @param mbid The MusicBrainz identifier for the artist.
	 * @return The Artist, or null if not found.
	 */
	public Artist? get_artist_by_mbid(string mbid) throws StoreError {
		return Artist.from_mbid(db, mbid);
	}
	
	/**
	 * Save an Artist, updating or creating it as necessary.
	 *
	 * @param artist The Artist object to save to the database
	 */
	public void save_artist(Artist artist) throws StoreError {
		/*
		 * Depending on whether the artist already has an ID, we
		 * choose between inserting and updating.
		 */
		if (artist.id == 0) {
			artist.insert(db);
		}
	}
}

}
