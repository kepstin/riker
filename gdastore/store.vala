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
	
	private const string DSN_NAME = "RikerStore";

	private const string DSN_PROVIDER = "SQLite";
	
	private const string DSN_DB_NAME = "riker-store";
	
	/**
	 * The Database connection.
	 */
	private Gda.Connection connection;

	/**
	 * Create a new Store instance using the default database location.
	 *
	 * This is normally in a ~/.local/share/riker/store.db, but varies by
	 * platform.
	 */
	public Store() {
		
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

		/* Attempt to connect using the libgda database configuration */
		try {
			connection = Gda.Connection.open_from_dsn("RikerStore", null, Gda.ConnectionOptions.NONE);
		} catch (Error error) {
			if (error.domain == Gda.Connection.error_quark() &&
				error.code == Gda.ConnectionError.DSN_NOT_FOUND_ERROR) {
				/*
				 * There is no database configuration for Riker,
				 * so create a default configuration.
				 */
				stderr.printf("Database configuration not found, creating default.\n");
				create_dsn();
				try {
					connection = Gda.Connection.open_from_dsn("RikerStore", null, Gda.ConnectionOptions.NONE);
				} catch (Error inner_error) {
					throw new StoreError.OPEN_FAILED("Failed to connect to database: " + inner_error.message);
				}
			} else {
				throw new StoreError.OPEN_FAILED("Failed to connect to database: " + error.message);
			}
		}
	}
	
	private void create_dsn() throws StoreError {
		var dsn_db_dir = Path.build_filename(Environment.get_user_data_dir(), Config.PACKAGE_TARNAME);
		var cnc_string = "DB_DIR=%s;DB_NAME=%s;FK=TRUE".printf(dsn_db_dir, DSN_DB_NAME);

		Gda.DsnInfo dsn_info = {
			DSN_NAME,
			DSN_PROVIDER,
			null,
			cnc_string,
			null,
			false
		};

		try {
			Gda.Config.define_dsn(dsn_info);
			connection = Gda.Connection.open_from_dsn("RikerStore", null, Gda.ConnectionOptions.NONE);
		} catch (Error inner_error) {
			throw new StoreError.OPEN_FAILED("Failed to create DB configuration: " + inner_error.message);
		}
	}

	/**
	 * Load the base schema into a fresh database.
	 */
	private void initialize_schema() throws StoreError {

	}
}

}
