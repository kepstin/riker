namespace Riker {

public class Store {
	private string path;
	private Sqlite.Database db;
	
	public void open() {
		var rc = Sqlite.Database.open(path, out db);
	}
	
	public Store() {
		path = Path.build_filename(Environment.get_user_data_dir(), "riker", "store.db");
	}
	
	public Store.from_path(string path) {
		this.path = path;
	}
}

}
