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

public static int main(string[] args) {

#if ENABLE_UNINSTALLED
	stderr.printf("This is an UNINSTALLED build. Do not install it.\n");
	stderr.printf("Using files from source directory: %s\n", Config.BUILD_SRCDIR);
#endif

	var store = new Store();
	
	try {
		store.open();
	} catch (StoreError e) {
		if (e is StoreError.CORRUPT_DB) {
			stderr.printf("%s\n", e.message);
			stderr.printf("To resolve this, try deleting the database file so it can be re-created.\n");
			stderr.printf("Database path: %s\n", store.path);
		} else {
			stderr.printf("%s\n", e.message);
		}
		return 1;
	}
	
	string artist_mbid = "b6c18308-82c7-4ec1-a42d-e8488bce6618";
	if (args.length >= 2) {
		artist_mbid = args[1];
	}

	stderr.printf("Looking up artist with mbid %s in local DB\n", artist_mbid);
	
	Artist a = null;
	try {
		a = store.get_artist_by_mbid(artist_mbid);
	} catch (StoreError e) {
		stderr.printf("%s", e.message);
		return 1;
	}
	if (a != null) {
		stdout.printf("%" + int64.FORMAT + " %s %s %s\n", a.id, a.mbid, a.name, a.sort_name);
		return 0;
	} else {
		stderr.printf("Artist not found in local db\n");
	}
	
	stderr.printf("Looking up artist with mbid %s on webservice\n", artist_mbid);
	
	Mb4.Query mb = new Mb4.Query("Riker/0.1 ( http://www.kepstin.ca/projects/riker )");
	Mb4.Metadata m = mb.query("artist", artist_mbid, null, inc: "aliases");
	
	unowned Mb4.Artist mba = m.artist;
	if (mba == null) {
		stderr.printf("Failed to lookup artist\n");
		return 1;
	}
	
	a = new Artist();
	
	a.mbid = mba.id;
	a.name = mba.name;
	a.sort_name = mba.sortname;
	
	stderr.printf("Saving artist to local db\n");
	try {
		store.save_artist(a);
	} catch (StoreError e) {
		stderr.printf("%s", e.message);
		return 1;
	}
	
	stdout.printf("%" + int64.FORMAT + " %s %s %s\n", a.id, a.mbid, a.name, a.sort_name);
	
	return 0;
}

}
