/*
  
  Mb4VapiGenerator, generator of .vapi for libmusicbrainz4.
  Copyright (C) 2012 Artem Tarasov
  
  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
    
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA 
  
*/

string uncamel (string text) {
    var sb = new StringBuilder ();
    var len = text.length;
    for (int i = 0; i < len; i++) {
        if (i > 1 && text[i].isupper() &&
            ((text[i-1].islower()) || (i+1 < len && text[i+1].islower())))
            sb.append_c ('_');
        sb.append_c (text[i].tolower());
    }
    return sb.str;
}

string capitalize_str (string str) {
    return str[0].toupper ().to_string () + str.substring (1);
}

string capitalize (Xml.Node * node) {
    var uppername = node -> get_prop ("uppername");
    if (uppername != null) {
        return uppername;
    }
    return capitalize_str (node -> get_prop("name"));
}

public abstract class XMLVisitor {
    static const int SHIFT_WIDTH = 4;

    Xml.Doc * doc;
    FileStream? output;
    
    protected int indent;
    protected string current_namespace;
    protected string? header_filename = null;
    protected string current_classname;

    protected XMLVisitor (string infile, string outfile)
    {
        Xml.Parser.init ();
        doc = Xml.Parser.parse_file (infile);
        indent = -SHIFT_WIDTH;

        output = FileStream.open (outfile, "w+");
    }

    ~XMLVisitor () {
        Xml.Parser.cleanup ();
        if (doc != null) delete doc;
    }

    protected void inc () { indent += SHIFT_WIDTH; }
    protected void dec () { indent -= SHIFT_WIDTH; }
    protected void _ (string str) {
        if (output != null) {
            assert (indent >= 0);
            var sb = new StringBuilder ();
            for (int i = 0; i < indent; ++i)
                sb.append_c (' ');
            sb.append (str);
            sb.append_c ('\n');
            output.write (sb.str.data);
        }
    }

    public void process () throws FileError { 
        if (output == null) {
            throw new FileError.FAILED (@"Failed to open output file for writing.");
        }
        if (doc != null) {
            var root = doc -> get_root_element();
            visit (root);
        }
    }

    protected void visit (Xml.Node * node) throws FileError {
        inc ();
        switch (node -> name) {
            case "cinterface":
                visit_cinterface (node); break;
            case "class":
                visit_class_helper (node); break;
            case "property":
                visit_property (node); break;
            case "list":
                visit_list (node); break;
            case "boilerplate":
                visit_boilerplate (node);
                break;
            case "entity":
                visit_entity (); 
                break;
        }
        dec ();
    }

    void visit_header () {
          _ ("""/* --------------------------------------------------------------------------

   THIS FILE IS AUTOMATICALLY GENERATED - DO NOT EDIT IT!

----------------------------------------------------------------------------*/
""");
    }

    protected void visit_children (Xml.Node * node) throws FileError {
        Xml.Node * child = node -> children;
        while (child != null) {
            visit (child);
            if (child != null) { // someone might have modified the variable
                child = child -> next;
            }
        }
    }
    
    void visit_cinterface (Xml.Node * node) throws FileError {
        Xml.Node * child = node -> children;
        while (child != null && child -> name != "header") {
            child = child -> next;
        }
        if (child == null) {
            stderr.printf ("WARNING: generating .vapi without license header!\n");
        } else {
            visit_header ();
        }

        var ns = capitalize_str (current_namespace);
        if (header_filename != null) {
            _ (@"[CCode (cheader_filename = \"$(header_filename)\")]");
        }
        _ (@"namespace $ns {");
        visit_children (node);
        _ ( "}");
    }

    void visit_class_helper (Xml.Node * node) throws FileError {
        Xml.Node * class_node = node;
        node = node -> next;
        while (node -> next != null) {
            if (node -> name == "boilerplate") {
                Xml.Node * tmp = node -> next;
                node -> unlink ();
                class_node -> add_child (node);
                node = tmp;
            } else {
                if (node -> name != "text") {
                    break;
                }
                node = node -> next;
            }
        }

        visit_class (class_node);
    }

    protected virtual void visit_class (Xml.Node * node) throws FileError {}
    protected virtual void visit_property (Xml.Node * node) {}
    protected virtual void visit_list (Xml.Node * node) throws FileError {}
    protected virtual void visit_boilerplate (Xml.Node * node) throws FileError {}

    protected void visit_boilerplate_helper (Xml.Node * node, string type) throws FileError {
        if (node -> get_prop ("target") != type) return;

        var file = node -> get_prop ("file");
        if (file == null) return;
        file = "vala" + file.substring(1); // change "c" to "vala"
        var input = FileStream.open (file, "r");
        if (input == null) {
            throw new FileError.FAILED (@"failed to open $file");
        } else {
            string? line;
            while ((line = input.read_line()) != null)
                _ (line);
        }
    }

    protected virtual void visit_entity () {}
}

public class HighLevelBindingsGenerator : XMLVisitor {
    string low_level_namespace = "Mb4";
    public HighLevelBindingsGenerator (string infile = "cinterface.xml",
                                       string outfile = "musicbrainz-4.0.vala")
    {
        base (infile, outfile);
        current_namespace = "musicbrainz";
        header_filename = null;
    }

    void entity_ext_helper (string s, string map_type) {
        _ (@"var _ext_$(s)s_size = instance -> ext_$(s)s_size ();");
        _ (@"_ext_$(s)s = new $(map_type) ();");
        _ (@"for (var i = 0; i < _ext_$(s)s_size; ++i) {");
        inc (); _ (@"var _name = instance -> ext_$(s)_name (i);");
                _ (@"var _value = instance -> ext_$(s)_value (i);");
                _ (@"_ext_$(s)s[_name] = _value;"); dec ();
        _ ( "}");
    }

    protected override void visit_entity () {
        var u = "Entity";
        var n = low_level_namespace;
        var map_t = "Gee.HashMap<string, string>";
        _ (@"public class $u {");
        inc (); _ (@"internal $n.$u* instance;");

                _ ( "[CCode (has_target=false)]");
                _ (@"internal delegate void DeleteFunc ($n.$u* entity);");
                _ ( "unowned DeleteFunc? delete_func;");

                _ (@"$(map_t) _ext_attributes;");
                _ (@"$(map_t) _ext_elements;");

                _ (@"public $(map_t) ext_attributes {");
                _ ( "    get { return _ext_attributes; }");
                _ ( "}");

                _ (@"public $(map_t) ext_elements {");
                _ ( "    get { return _ext_elements; }");
                _ ( "}");

                _ (@"internal void wrap_helper ($n.$u* entity, DeleteFunc? delete_func) {");
                inc (); _ ("this.instance = entity;");
                        _ ("this.delete_func = delete_func;");
                        entity_ext_helper ("attribute", map_t);     
                        entity_ext_helper ("element", map_t); dec (); 
                _ ( "}");

                _ (@"internal $u.wrap ($n.$u* entity, DeleteFunc? delete_func) {");
                _ ( "    wrap_helper (entity, delete_func);");
                _ ( "}");

                _ (@"~$u () { ");
                _ ( "    if (delete_func != null)");
                _ ( "        delete_func (instance);");
                _ ( "}"); dec ();
        _ ( "}");
    }

    void create_wrap_and_dup (Xml.Node * node) {
        var u = current_classname;
        var n = low_level_namespace; 
        inc (); _ (@"internal $u.wrap ($n.$u* instance, bool has_parent=true) {");
                inc (); _ (@"Entity.DeleteFunc func = (obj) => {");
                        _ (@"    $n.$u* _obj = ($n.$u*)obj;");
                        _ ( "    if (_obj != null) delete _obj;");
                        _ ( "};");
                        _ (@"base.wrap_helper (instance, has_parent ? null : func);"); dec ();
                _ ( "}");
        
                _ (@"public $u dup () {");
                _ (@"    return new $u.wrap (new $n.$u.copy (($n.$u*) instance), false);");
                _ ( "}"); dec ();
    }

    protected override void visit_class (Xml.Node * node) throws FileError {
        var u = capitalize (node);
        current_classname = u; 
        if (u == "Query") {
            _ (@"public class $u {");
        } else {
            _ (@"public class $u : Entity {");
            create_wrap_and_dup (node);
        }
        visit_children (node);
        _ ( "}"); 
    }

    protected override void visit_property (Xml.Node * node) {
        var c = current_classname;   // the class which property belongs to
        var u = capitalize (node);   // the class of result if the type is 'object'
        var n = low_level_namespace; // Mb4
        var name = uncamel (u);      // property name
        if (name == "type") return; // FIXME: rename 'type' properties 
        var type = node -> get_prop ("type");
        switch (type) {
            case "object":
                _ (@"public $u? $name {");
                inc (); _ ( "owned get {");
                        inc (); _ (@"unowned $n.$u? result = (($n.$c*)instance) -> $name;");
                                _ ( "if (result == null) return null;");
                                _ (@"return new $u.wrap (result);"); dec ();
                        _ ( "}"); dec ();
                _ ("}");
                break;
            case "string":
            case "integer":
            case "double":
                if (type[0] == 'i') type = "int";
                _ (@"public $type $name {");
                inc (); _ ( "owned get {");
                        inc (); _ (@"return (($n.$c*)instance) -> $name;"); dec ();
                        _ ( "}"); dec ();
                _ ("}");
                break;
            default:
                break;
        }

    }

    protected override void visit_list (Xml.Node * node) throws FileError {
        var elem_class = capitalize (node);
        var n = low_level_namespace;
        var c = elem_class + "List";
        current_classname = c;

        _ (@"public class $c : Entity {");
        inc (); _ (@"$elem_class[] lst;");
                _ (@"internal $c.wrap ($n.$c* instance, bool has_parent=true) {");
                inc (); _ (@"Entity.DeleteFunc func = (obj) => { ");
                        _ (@"    $n.$c* _obj = ($n.$c*)obj;");
                        _ (@"    if (_obj != null) delete _obj;");
                        _ ( "};");
                        _ ( "base.wrap_helper (instance, has_parent ? null : func);"); // FIXME
                        _ ( "int size = instance -> size;");
                        _ (@"lst = new $elem_class[size];");
                        _ ( "for (var i = 0; i < size; ++i) {");
                        _ (@"    lst[i] = new $elem_class.wrap (instance -> get(i));");
                        _ ( "}"); dec ();
                _ ( "}");
                _ (@"public $c dup () {");
                _ (@"    return new $c.wrap (new $n.$c.copy (($n.$c*) instance), false);");
                _ ( "}");
                _ ( "public int size { get { return lst.length; } }");
                _ (@"public $elem_class get (int item) { return lst[item]; }"); dec ();
                visit_children (node);
        _ ("}");
    }

    protected override void visit_boilerplate (Xml.Node * node) throws FileError {
        if (node -> get_prop ("file") == "c-int-source-funcs.inc") return;
        visit_boilerplate_helper (node, "source");
    }

} // HighLevelBindingsGenerator

public class VapiGenerator : XMLVisitor {
    public VapiGenerator (string infile = "cinterface.xml",
                          string outfile = "libmusicbrainz4.vapi") 
    {
        base (infile, outfile);
        current_namespace = "mb4";
        header_filename = "musicbrainz4/mb4_c.h";
    }

    protected override void visit_class (Xml.Node * node) throws FileError {
        var c = current_classname = node -> get_prop ("name");
        var u = capitalize (node);
        var n = current_namespace;
        _ ( "[Compact]");
        _ (@"[CCode (free_function = \"$(n)_$(c)_delete\", lower_case_cprefix = \"$(n)_$(c)_\")]");
        _ (@"public class $u" + (u != "Query" ? " : Entity {" : " {"));
        inc (); _ (@"[CCode (cname = \"$(n)_$(c)_clone\")]");
                _ (@"public $u.copy($u $c);"); dec ();
        visit_children (node);
        _ ( "}\n");
    }

    protected override void visit_property (Xml.Node * node) {
        var name = node -> get_prop ("name");
        var u = capitalize (node);
        var vala_name = uncamel (u);
        var n = current_namespace;
        var c = current_classname;

        var type = node -> get_prop ("type");
        switch (type) {
            case "string":
                _ ( "");
                _ (@"[CCode (cname = \"$(n)_$(c)_get_$name\")]");
                _ (@"int get_$(vala_name)_array (char[]? str);");
                _ (@"public string $(vala_name) {");
                inc (); _ (@"[CCode (cname = \"$(n)_$(c)_get_$(name)_wrapper\")]");
                        _ ( "owned get {");
                        inc (); _ (@"int size = get_$(vala_name)_array (null);");
                                _ ( "char[] buf = new char[size + 1];");
                                _ (@"get_$(vala_name)_array (buf);");
                                _ ( "return (string) buf;"); dec ();
                        _ ( "}"); dec ();
                _ ( "}");
                break;
            case "object":
                _ (@"public $u? $(vala_name) {");
                inc (); _ (@"[CCode (cname = \"$(n)_$(c)_get_$name\")]");
                        _ ( "get;"); dec ();
                _ ( "}");
                break;
            case "integer":
            case "double":
                if (type[0] == 'i') type = "int";
                _ (@"public $type $(vala_name) {");
                inc (); _ (@"[CCode (cname = \"$(n)_$(c)_get_$name\")]");
                        _ ( "get;"); dec ();
                _ ( "}");
                break;
            default:
                stderr.printf (@"unknown type of property: '$type' - skipped\n");
                break;
        }
    }

    protected override void visit_list (Xml.Node * node) throws FileError {
        var e = node -> get_prop ("name");
        var ue = capitalize (node);
        var n = current_namespace;
        var c = ue + "List";
        var lc = e + "_list";
        current_classname = lc;

        _ ( "[Compact]");
        _ (@"[CCode (free_function = \"$(n)_$(lc)_delete\")]");
        _ (@"public class $c : Entity {");
        inc (); _ ( "public int size {");
                inc (); _ (@"[CCode (cname = \"$(n)_$(lc)_size\")]");
                        _ ( "get;"); dec ();
                _ ( "}");
                _ (@"[CCode (cname = \"$(n)_$(lc)_item\")]");
                _ (@"public unowned $ue get (int item);");
                _ ( "public int count { get; }");
                _ ( "public int offset { get; }");
                _ (@"[CCode (cname = \"$(n)_$(lc)_clone\")]");
                _ (@"public $c.copy ($c $lc);"); dec ();
        visit_children (node);
        _ ( "}\n");
    }

    protected override void visit_boilerplate (Xml.Node * node) throws FileError {
        visit_boilerplate_helper (node, "include");
    }

    void entity_inner_helper (string name, string prefix) {
        var n = current_namespace;
        var c = "entity";
        _ (@"[CCode (cname = \"$(n)_$(c)_$(prefix)_$(name)\")]");
        _ (@"int $(prefix)_$(name)_array (int item, char[]? str);");
        _ (@"[CCode (cname = \"$(n)_$(c)_$(prefix)_$(name)_wrapper\")]");
        _ (@"public string $(prefix)_$(name) (int item) {");
        inc (); _ (@"int size = $(prefix)_$(name)_array (item, null);");
                _ (@"char[] buf = new char[size + 1];");
                _ (@"$(prefix)_$(name)_array (item, buf);");
                _ ( "return (string) buf;"); dec ();
        _ ( "}");
    }

    void entity_helper (string str) {
        _ (@"public int ext_$(str)s_size ();");
        entity_inner_helper ("name", @"ext_$str");
        entity_inner_helper ("value", @"ext_$str");
    }

    protected override void visit_entity () {
        _ ("[Compact]");
        _ ("public class Entity {");
        inc (); entity_helper ("attribute");
                entity_helper ("element"); dec ();
        _ ("}\n");
    }
}

void main (string[] args) {
    if (args.length > 2) {
        stdout.printf ("usage: mb4_vapi_generator [xmlfile]\n");
        stdout.printf ("\t(xmlfile defaults to \"cinterface.xml\")\n");
    }
    string infile;
    if (args.length == 1) {
        infile = "cinterface.xml";
    } else {
        infile = args[1];
    }
    try {
        new VapiGenerator (infile).process ();
        new HighLevelBindingsGenerator (infile).process ();
    } catch (FileError e) {
        stderr.printf ("%s\n", e.message);
    }
}
