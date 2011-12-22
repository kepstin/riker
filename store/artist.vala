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
	 * Riker's internal representation of a MusicBrainz artist.
	 */
	public class Artist: Object {

		private int64 _id;
		private string _mbid;
		private string _name;
		private string _sort_name;

		public static const string select_by_id_sql = "SELECT artist.id, artist_mbid.mbid, artist.name, artist.sort_name FROM artist, artist_mbid WHERE artist.id = ? AND artist_mbid.artist = artist.id;";
		public static const string select_from_mbid_sql = "SELECT artist.id, artist_mbid.mbid, artist.name, artist.sort_name FROM artist, artist_mbid WHERE artist_mbid.mbid = ? AND artist_mbid.artist = artist.id;";
		private static const string insert_sql = "INSERT INTO artist (name, sort_name) VALUES (?, ?);";
		private static const string insert_mbid_sql = "INSERT INTO artist_mbid (mbid, artist) VALUES (?, ?);";

		private Artist.from_row(Sqlite.Statement stmt) {
			Object(id: stmt.column_int(0), mbid: stmt.column_text(1), name: stmt.column_text(2), sort_name: stmt.column_text(3));
		}
		
		/**
		 * Lookup an artist in a db by an MBID.
		 *
		 * @param db The database to look up the artist in.
		 * @param mbid The MBID of the artist to look up.
		 * @return The artist if found, or null otherwise.
		 */
		public static Artist? from_mbid(Sqlite.Database db, string mbid) throws StoreError {
			int rc;
			Artist artist = null;
			Sqlite.Statement stmt;

			rc = db.prepare_v2(select_from_mbid_sql, select_from_mbid_sql.length, out stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}

			stmt.bind_text(1, mbid);

			while ((rc = stmt.step()) == Sqlite.ROW) {
				artist = new Artist.from_row(stmt);
			}
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
			}
			return artist;
		}

		/**
		 * Insert this artist into the db as a new artist.
		 *
		 * After the insert, the id field will be updated with the row
		 * id of the newly created artist in the database.
		 *
		 * @param db The database to insert the artist into.
		 */
		public void insert(Sqlite.Database db) throws StoreError {
			int rc;
			Sqlite.Statement stmt;

			/* Insert the artist */
			rc = db.prepare_v2(insert_sql, insert_sql.length, out stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}
			
			stmt.bind_text(1, name);
			stmt.bind_text(2, sort_name);
			
			rc = stmt.step();
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("Error executing sql: " + db.errmsg());
			}
			
			_id = db.last_insert_rowid();
			if (_id == 0) {
				throw new StoreError.BUG("No returned rowid");
			}

			/* Insert the MBID */
			rc = db.prepare_v2(insert_mbid_sql, insert_mbid_sql.length, out stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}

			stmt.bind_text(1, mbid);
			stmt.bind_int64(2, id);

			rc = stmt.step();
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("Error executing sql: " + db.errmsg());
			}
		}

		/**
		 * The ID (row number) of the Artist.
		 */
		public int64 id {
			get {
				return _id;
			}
			construct {
				_id = value;
			}
		}
		
		/**
		 * The MusicBrainz identifier for the Artist.
		 *
		 * TODO: Support multiple mbids per entity.
		 */
		public string mbid {
			get {
				return _mbid;
			}
			construct set {
				_mbid = value;
			}
		}

		/**
		 * The name of the Artist.
		 */
		public string name {
			get {
				return _name;
			}
			construct set {
				_name = value;
			}
		}

		/**
		 * The sort name of the Artist.
		 */
		public string sort_name {
			get {
				return _sort_name;
			}
			construct set {
				_sort_name = value;
			}
		}
	}
}
