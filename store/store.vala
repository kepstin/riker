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

public class Store: Object {
	
	private const uint SCHEMA_VERSION = 0;
	private const uint SUPPORTED_SCHEMA_VERSION = 1;	
	
	public string path {
		private get;
		construct;
	}
	
	private Sqlite.Database db;
	
	public Store() {
		Object(path: Path.build_filename(Environment.get_user_data_dir(), "riker", "store.db"));
	}
	
	public Store.from_path(string path) {
		Object(path: path);
	}
	
	public void open() {
		if (SCHEMA_VERSION == 0) {
			print(
"This version of Riker uses an unstable database schema. If you update Riker\n" +
"to a new version, you must delete the database file and either restore a\n" +
"backup from a stable version or rescan your music collection.\n");
		}
		
		DirUtils.create_with_parents(Path.get_dirname(path), 0700);
		var rc = Sqlite.Database.open(path, out db);
		if (rc != Sqlite.OK) {
			stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
			return; // TODO error handling...
		}
		
		// Query the database for its schema version
	}
	
	public void add_file(File file) {
		
	}
}

}
