namespace Riker {

public class Store {
	private string path;
	private Sqlite.Database db;
	
	public void open() {
		DirUtils.create_with_parents(Path.get_dirname(path), 0700);
		var rc = Sqlite.Database.open(path, out db);
		if (rc != Sqlite.OK) {
			stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
			return;
		}
	}
	
	public Store() {
		path = Path.build_filename(Environment.get_user_data_dir(), "riker", "store.db");
	}
	
	public Store.from_path(string path) {
		this.path = path;
	}
}

}
