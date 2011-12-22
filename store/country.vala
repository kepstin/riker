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
	 * Riker's internal representation of a MusicBrainz Country.
	 */
	public class Country: Object {

		private int64 _id;
		private string _iso_code;
		private string _name;

		public static const string select_by_id_sql = "SELECT id, iso_code, name FROM country WHERE id = ?";
		public static const string select_by_iso_code_sql = "SELECT id, iso_code, name FROM country WHERE iso_code = ?";

		public Country.from_row(Sqlite.Statement stmt) {
			Object(id: stmt.column_int(0), iso_code: stmt.column_text(1), name: stmt.column_text(2));
		}

		/**
		 * Lookup a Country in a db by its row ID.
		 *
		 * @param db The database to look up the artist in.
		 * @param id The row ID of the country to look up.
		 * @return The country if found, or null otherwise.
		 */
		public static Country? from_id(Sqlite.Database db, int64 id) throws StoreError {
			int rc;
			Country country = null;
			Sqlite.Statement stmt;

			rc = db.prepare_v2(Country.select_by_id_sql, Country.select_by_id_sql.length, out stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}

			stmt.bind_int64(1, id);
			while ((rc = stmt.step()) == Sqlite.ROW) {
				country = new Country.from_row(stmt);
			}
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
			}
			return country;
		}

		public static Country? from_iso_code(Sqlite.Database db, string iso_code) throws StoreError {
			int rc;
			Country country = null;
			Sqlite.Statement stmt;

			rc = db.prepare_v2(Country.select_by_iso_code_sql, Country.select_by_iso_code_sql.length, out stmt);
			if (rc != Sqlite.OK) {
				throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
			}

			stmt.bind_text(1, iso_code);
			while ((rc = stmt.step()) == Sqlite.ROW) {
				country = new Country.from_row(stmt);
			}
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("BUG: Error executing sql: " + db.errmsg());
			}
			return country;
		}

		/**
		 * The ID (row number) of the Country.
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
		 * The two-character ISO code for the Country.
		 */
		public string iso_code {
			get {
				return _iso_code;
			}
			construct {
				_iso_code = value;
			}
		}

		/**
		 * The name of the Country.
		 */
		public string name {
			get {
				return _name;
			}
			construct {
				_name = value;
			}
		}
	}
}
