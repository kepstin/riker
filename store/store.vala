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

public errordomain StoreError {
	OPEN_FAILED,
	DB_TOO_OLD,
	DB_TOO_NEW,
	CORRUPT_DB,
	INSTALLATION_ERROR,
	BUG
}

public class Store: Object {
	
	private const uint SCHEMA_VERSION = 0;
	private const uint SUPPORTED_SCHEMA_VERSION = 1;	
	
	public string path {
		get;
		construct;
	}
	
	private Sqlite.Database _db;
	public unowned Sqlite.Database db {
		get {
			return _db;
		}
	}
	
	public Store() {
		Object(path: Path.build_filename(Environment.get_user_data_dir(), "riker", "store.db"));
	}
	
	public Store.from_path(string path) {
		Object(path: path);
	}
	
	public void open() throws StoreError {
		if (SCHEMA_VERSION == 0) {
			stderr.printf(
"This version of Riker uses an unstable database schema. If you update Riker\n" +
"you must delete the database file and either restore a backup from an older\n" +
"stable version or rescan your music collection.\n");
		}
		
		stderr.printf("Database location: %s\n", path);
		
		bool existing_db;
		if (FileUtils.test(path, FileTest.IS_REGULAR)) {
			stderr.printf("Database already exists, attempting to open it.\n");
			existing_db = true;
		} else {
			stderr.printf("Database does not exist, creating a new one.\n");
			existing_db = false;
			DirUtils.create_with_parents(Path.get_dirname(path), 0700);
		}
		
		var rc = Sqlite.Database.open(path, out _db);
		if (rc != Sqlite.OK) {
			throw new StoreError.OPEN_FAILED("Could not open database: " + db.errmsg());
		}
		stderr.printf("Database opened.\n");
		
		if (!existing_db) {
			load_schema();
		}
		
		// Query the database for its schema version
		Sqlite.Statement st;
		var query = "SELECT schema_version FROM riker";
		rc = db.prepare_v2(query, query.length, out st);
		if (rc != Sqlite.OK) {
			throw new StoreError.CORRUPT_DB("Corrupt database: " + db.errmsg());
		}
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
	
	public Country? get_country_by_id(int id) throws StoreError {
		int rc;
		Country country = null;

		if (Country.select_by_id_stmt == null) {
			rc = db.prepare_v2(Country.select_by_id, Country.select_by_id.length, out Country.select_by_id_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}
		
		Country.select_by_id_stmt.bind_int(1, id);
		while ((rc = Country.select_by_id_stmt.step()) == Sqlite.ROW) {
			country = new Country.from_row(Country.select_by_id_stmt);
		}
		Country.select_by_id_stmt.reset();
		if (rc != Sqlite.DONE) {
			throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
		}
		return country;
	}

	public Country? get_country_by_iso_code(string iso_code) throws StoreError {
		int rc;
		Country country = null;

		if (Country.select_by_id_stmt == null) {
			rc = db.prepare_v2(Country.select_by_iso_code, Country.select_by_iso_code.length, out Country.select_by_iso_code_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}

		Country.select_by_iso_code_stmt.bind_text(1, iso_code);
		while ((rc = Country.select_by_iso_code_stmt.step()) == Sqlite.ROW) {
			country = new Country.from_row(Country.select_by_iso_code_stmt);
		}
		Country.select_by_iso_code_stmt.reset();
		if (rc != Sqlite.DONE) {
			throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
		}
		return country;
	}

	public ArtistType? get_artist_type_by_id(int id) throws StoreError {
		int rc;
		ArtistType artist_type = null;

		if (ArtistType.select_by_id_stmt == null) {
			rc = db.prepare_v2(ArtistType.select_by_id, ArtistType.select_by_id.length, out ArtistType.select_by_id_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}
		
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

	public ArtistType? get_artist_type_by_name(string name) throws StoreError {
		int rc;
		ArtistType artist_type = null;

		if (ArtistType.select_by_name_stmt == null) {
			rc = db.prepare_v2(ArtistType.select_by_name, ArtistType.select_by_name.length, out ArtistType.select_by_name_stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
		}
		
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
}

}
