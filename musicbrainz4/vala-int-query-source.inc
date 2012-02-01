Mb4.Query * instance;
public Query (string user_agent, string? server = null, int port = 0) {
	instance = new Mb4.Query (user_agent, server, port);
}
~Query () {
	delete instance;
}

public string username { set { instance -> username = value; } }
public string password { set { instance -> password = value; } }
public string proxy_host { set { instance -> proxy_host = value; } }
public int proxy_port { set { instance -> proxy_port = value; } }
public string proxy_username { set { instance -> proxy_username = value; } }
public string proxy_password { set { instance -> proxy_password = value; } }

public ReleaseList lookup_disc_id (string disc_id) {
	return new ReleaseList.wrap (instance -> lookup_disc_id (disc_id), false);
}

public Release lookup_release (string release) {
	return new Release.wrap (instance -> lookup_release (release), false);
}

public Metadata query (string entity, string? id, string? resource, ...) {
    string[] param_names = new string[0];
    string[] param_values = new string[0];
    var l = va_list();
    while (true) {
        string? name = l.arg();
        if (name == null) {
            break;
        }
        string val = l.arg();
        param_names += name;
        param_values += val;
    }
    return new Metadata.wrap (instance -> query_array(entity, id, resource, 
									param_names.length, param_names, param_values), false);
}

public Mb4.Query.Result last_result {
	get { return instance -> last_result; }
}
