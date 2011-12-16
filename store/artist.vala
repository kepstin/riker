namespace Riker {
	public class Artist: Object {

		private int64 _id;
		private string _mbid;
		private string _name;
		private string _sort_name;

		public static const string select_by_id = "SELECT id, gid, name, sort_name FROM artist WHERE id = ?;";
		public static Sqlite.Statement select_by_id_stmt = null;
		public static const string select_by_mbid = "SELECT id, gid, name, sort_name FROM artist WHERE gid = ?;";
		public static Sqlite.Statement select_by_mbid_stmt = null;
		
		private static const string insert_sql = "INSERT INTO artist (gid, name, sort_name) VALUES (?, ?, ?);";
		private static Sqlite.Statement insert_stmt = null;

		public Artist.from_row(Sqlite.Statement stmt) {
			Object(id: stmt.column_int(0), mbid: stmt.column_text(1), name: stmt.column_text(2), sort_name: stmt.column_text(3));
		}
		
		public void insert(Sqlite.Database db) throws StoreError {
			int rc;

			if (insert_stmt == null) {
				rc = db.prepare_v2(insert_sql, insert_sql.length, out insert_stmt);
				if (rc != Sqlite.OK) {
					throw new StoreError.BUG("Failed to prepare statement: " + db.errmsg());
				}
			}
			insert_stmt.reset();
			
			insert_stmt.bind_text(1, mbid);
			insert_stmt.bind_text(2, name);
			insert_stmt.bind_text(3, sort_name);
			
			rc = insert_stmt.step();
			if (rc != Sqlite.DONE) {
				throw new StoreError.BUG("Error executing sql: " + db.errmsg());
			}
			
			_id = db.last_insert_rowid();
			if (_id == 0) {
				throw new StoreError.BUG("No returned rowid");
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
