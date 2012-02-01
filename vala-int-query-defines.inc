public Query(string user_agent, string? server = null, int port = 0);

public string username { set; }

public string password { set; }

public string proxy_host { 
    [CCode (cname = "mb4_query_set_proxyhost")]
    set; 
}

public int proxy_port { 
    [CCode (cname = "mb4_query_set_proxyport")]
    set; 
}

public string proxy_username {
    [CCode (cname = "mb4_query_set_proxyusername")]
    set;
}

public string proxy_password {
    [CCode (cname = "mb4_query_set_proxypassword")]
    set;
}

[CCode (cname = "mb4_query_lookup_discid")]
public ReleaseList lookup_disc_id(string disc_id);

public Release lookup_release(string release);

[CCode (cname = "mb4_query_query")]
public Metadata query_array(string entity, string? id, string? resource, int num_params, string* param_names, string* param_values);

[CCode (cname = "mb4_query_query_wrapper")]
public Metadata query(string entity, string? id, string? resource, ...) {
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
    return query_array(entity, id, resource, param_names.length, param_names, param_values);
}

[CCode (cname = "mb4_query_add_collection_entries")]
public bool add_collection_entries_array(string collection, [CCode (array_length_pos=1.5)] string[] entries);

[CCode (cname = "mb4_query_add_collection_wrapper")]
public bool add_collection_entries(string collection, ...) {
    string[] entries = new string[0];
    var l = va_list();
    while (true) {
        string? entry = l.arg();
        if (entry == null) {
            break;
        }
        entries += entry;
    }
    return add_collection_entries_array(collection, entries);
}

[CCode (cname = "mb4_query_delete_collection_entries")]
public bool delete_collection_entries_array(string collection, [CCode (array_length_pos=1.5)] string[] entries);

[CCode (cname = "mb4_query_delete_collection_wrapper")]
public bool delete_collection_entries(string collection, ...) {
    string[] entries = new string[0];
    var l = va_list();
    while (true) {
        string? entry = l.arg();
        if (entry == null) {
            break;
        }
        entries += entry;
    }
    return delete_collection_entries_array(collection, entries);
}

[CCode (cname = "tQueryResult")]
public enum Result {
    [CCode (cname = "eQuery_Success")]
    SUCCESS,
    [CCode (cname = "eQuery_ConnectionError")]
    CONNECTION_ERROR,
    [CCode (cname = "eQuery_Timeout")]
    TIMEOUT,
    [CCode (cname = "eQuery_AuthenticationError")]
    AUTHENTICATION_ERROR,
    [CCode (cname = "eQuery_FetchError")]
    FETCH_ERROR,
    [CCode (cname = "eQuery_RequestError")]
    REQUEST_ERROR,
    [CCode (cname = "eQuery_ResourceNotFound")]
    RESOURCE_NOT_FOUND
}

public Result last_result { 
    [CCode (cname = "mb4_query_get_lastresult")]
    get; 
}
