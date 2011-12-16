namespace Riker {
	public class Artist: Object {

		private int64 _id;
		private string _mbid;
		private string _name;
		private string _sort_name;

		public static const string select_by_id = "SELECT artist.id, artist_mbid.mbid, artist.name, artist.sort_name FROM artist, artist_mbid WHERE artist.id = ? AND artist_mbid.artist = artist.id;";
		public static Sqlite.Statement select_by_id_stmt = null;
		public static const string select_by_mbid = "SELECT artist.id, artist_mbid.mbid, artist.name, artist.sort_name FROM artist, artist_mbid WHERE artist_mbid.mbid = ? AND artist_mbid.artist = artist.id;";
		public static Sqlite.Statement select_by_mbid_stmt = null;
		
		private static const string insert_sql = "INSERT INTO artist (name, sort_name) VALUES (?, ?);";
		private static Sqlite.Statement insert_stmt = null;

		private static const string insert_mbid_sql = "INSERT INTO artist_mbid (mbid, artist) VALUES (?, ?);";
		private static Sqlite.Statement insert_mbid_stmt = null;

		public Artist.from_row(Sqlite.Statement stmt) {
			Object(id: stmt.column_int(0), mbid: stmt.column_text(1), name: stmt.column_text(2), sort_name: stmt.column_text(3));
		}
		
		public void insert(Sqlite.Database db) throws StoreError {
			int rc;

			// Insert the artist
			if (insert_stmt == null) {
				rc = db.prepare_v2(insert_sql, insert_sql.length, out insert_stmt);
				if (rc != Sqlite.OK) {
					throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
				}
			}
			insert_stmt.reset();
			
			insert_stmt.bind_text(1, name);
			insert_stmt.bind_text(2, sort_name);
			
			rc = insert_stmt.step();
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("Error executing sql: " + db.errmsg());
			}
			
			_id = db.last_insert_rowid();
			if (_id == 0) {
				throw new StoreError.BUG("No returned rowid");
			}

			// Insert the MBID
			if (insert_mbid_stmt == null) {
				rc = db.prepare_v2(insert_mbid_sql, insert_mbid_sql.length, out insert_mbid_stmt);
				if (rc != Sqlite.OK) {
					throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
				}
			}
			insert_mbid_stmt.reset();

			insert_mbid_stmt.bind_text(1, mbid);
			insert_mbid_stmt.bind_int64(2, id);

			rc = insert_mbid_stmt.step();
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
