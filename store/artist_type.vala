namespace Riker {
	public class ArtistType: Object {

		private int _id;
		private string _name;

		public static const string select_by_id = "SELECT id, name FROM artist_type WHERE id = ?";
		public static Sqlite.Statement select_by_id_stmt = null;
		public static const string select_by_name = "SELECT id, name FROM artist_type WHERE name = ?";
		public static Sqlite.Statement select_by_name_stmt = null;

		public ArtistType.from_row(Sqlite.Statement stmt) {
			Object(id: stmt.column_int(0), name: stmt.column_text(1));
		}

		/**
		 * The ID (row number) of the Artist Type.
		 */
		public int id {
			get {
				return _id;
			}
			construct {
				_id = value;
			}
		}

		/**
		 * The name of the Artist Type.
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
