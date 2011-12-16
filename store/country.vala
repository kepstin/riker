namespace Riker {
	public class Country: Object {

		private int _id;
		private string _iso_code;
		private string _name;

		public static const string select_by_id = "SELECT id, iso_code, name FROM country WHERE id = ?";
		public static Sqlite.Statement select_by_id_stmt = null;
		public static const string select_by_iso_code = "SELECT id, iso_code, name FROM country WHERE iso_code = ?";
		public static Sqlite.Statement select_by_iso_code_stmt = null;

		public Country.from_row(Sqlite.Statement stmt) {
			Object(id: stmt.column_int(0), iso_code: stmt.column_text(1), name: stmt.column_text(2));
		}

		/**
		 * The ID (row number) of the Country.
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
