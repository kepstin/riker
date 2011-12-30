#!/usr/bin/env python
import xml.etree.ElementTree

# in order for this script to work, manually do the following:
#    1) delete extraneous 'uppername="PUID"' at line 205 of cinterface.xml
#    2) delete '------------ ... ----' lines (there're 2 of them)

def un_camel(text): # slightly modified piece of code from StackOverflow.com
    result, length = "", len(text)
    for pos in range(length):
        if text[pos].isupper():
            if pos > 1 and text[pos-1].islower() or \
               pos > 1 and pos+1 < length and text[pos+1].islower():
                   result += "_"
        result += text[pos].lower()
    return result

################################################################################

def capitalize(node):
    return node.attrib.get('uppername') or node.attrib['name'].capitalize()

SHIFT_WIDTH = 4
class XMLVisitor:

    def __init__(self, infile='cinterface.xml',
                       outfile='libmusicbrainz4.vapi',
                       uncamel=True):
        xml_contents = open(infile).read()
        self.root = xml.etree.ElementTree.fromstring(xml_contents)
        self.out = open(outfile, 'w+')
        self.indent = -SHIFT_WIDTH

        self.uncamel = uncamel # determines whether to leave names like 'usertaglist'
                               #            or to convert to 'user_tag_list' based on
                               #            information available in XML file

        self.current_namespace = 'mb4'
        self.current_classname = ''

    def incr(self):
        self.indent += SHIFT_WIDTH

    def decr(self):
        self.indent -= SHIFT_WIDTH

    def process(self):
        self.visit(self.root)

    def writeln(self, str=''):
        self.out.write(' ' * self.indent)
        self.out.write(str)
        self.out.write('\n')

    def visit(self, node):
        tag = node.tag
        self.incr()
        if tag == 'cinterface':
            self.visit_cinterface(node)
        elif tag == 'class':
            self.visit_class(node)
        elif tag == 'property':
            self.visit_property(node)
        elif tag == 'list':
            self.visit_list(node)
        elif tag == 'boilerplate':
            pass 
        elif tag == 'entity':
            self.visit_entity()
        else:
            # print ('unknown tag: %s - skipped' % tag)
            pass
        self.decr()


    def visit_cinterface(self, node):
        namespace = self.current_namespace
        self.writeln ('[CCode (cheader_filename = "musicbrainz4/mb4_c.h")]')
        self.writeln ('namespace %s {' % namespace.capitalize())
        for child in node.getchildren ():
            self.visit (child)
        self.writeln ('}')

    def visit_class(self, node):
        classname = node.attrib['name']
        self.current_classname = classname
        uppername = capitalize (node)
        namespace = self.current_namespace
        self.writeln ('[Compact]')
        self.writeln ('[CCode (free_function = "%s_%s_delete", lower_case_cprefix = "%s_%s_")]' % 
                        (namespace, classname,    namespace, classname))
        self.writeln ('public class %s : Entity {' % uppername)
        self.incr ()
        self.writeln ('[CCode (cname = "%s_%s_clone")]' % (namespace, classname))
        self.writeln ('public %s.copy(%s %s);' % (uppername, uppername, classname))
        self.decr ()
        for child in node.getchildren ():
            self.visit (child)
        self.writeln ('}\n')

    def visit_property(self, node):

        name = node.attrib['name']

        uppername = capitalize (node)
        type = node.attrib['type']
        namespace = self.current_namespace
        classname = self.current_classname

        if self.uncamel:
            uncameled_name = un_camel (uppername) 
        else:
            uncameled_name = name

        if type == 'string':
            self.writeln ()
            self.writeln ('[CCode (cname = "%s_%s_get_%s")]' % 
                          (namespace, classname, name))
            self.writeln ('public int get_%s_array(char[]? str);' % uncameled_name)
            self.writeln ('public string %s {' % uncameled_name)
            self.incr ()
            self.writeln ('[CCode (cname = "%s_%s_get_%s_wrapper")]' %
                          (namespace, classname, name))
            self.writeln ('owned get {')
            self.incr ()
            self.writeln ('int size = get_%s_array(null);' % uncameled_name)
            self.writeln ('char[] buf = new char[size+1];')
            self.writeln ('get_%s_array(buf);' % uncameled_name)
            self.writeln ('return (string) buf;')
            self.decr ()
            self.writeln ('}')
            self.decr ()
            self.writeln ('}')
        elif type == 'object':
            self.writeln ('[CCode (cname = "%s_%s_get_%s")]' %
                          (namespace, classname, name))
            self.writeln ('public %s? %s { get; }' % (uppername, uncameled_name))
        elif type == 'integer' or type == 'double':
            self.writeln ('[CCode (cname = "%s_%s_get_%s")]' %
                          (namespace, classname, name))
            self.writeln ('public %s %s { get; }' % 
                            ("int" if type == "integer" else "double",
                             uncameled_name))
        else:
            print ('unknown type of property: "%s" - skipped' % type)
            pass

    def visit_list(self, node):
        element_name = node.attrib['name']
        element_uppername = capitalize (node)
        namespace = self.current_namespace;

        classname = element_uppername + "List"
        lowercase_classname = element_name + "_list"

        self.writeln ('[Compact]')
        self.writeln ('[CCode (free_function = "%s_%s_delete")]' %
                        (namespace, lowercase_classname))

        self.writeln ('public class %s : Entity {' % classname)
        self.incr ()
        self.writeln ('public int size {')
        self.incr ()
        self.writeln ('[CCode (cname = "%s_%s_size")]' % 
                        (namespace, lowercase_classname))
        self.writeln ('get;')
        self.decr ()
        self.writeln ('}')

        self.writeln ('[CCode (cname = "%s_%s_item")]' %
                        (namespace, lowercase_classname))
        self.writeln ('public unowned %s get(int item);' % element_uppername)
        self.writeln ('public int count { get; }');
        self.writeln ('public int offset { get; }');

        self.writeln ('[CCode (cname = "%s_%s_clone")]' %
                        (namespace, lowercase_classname))
        self.writeln ('public %s.copy(%s %s);' %
                        (classname, classname, lowercase_classname))
        self.decr ()
       
        self.current_classname = lowercase_classname # there might be properties
        for child in node.getchildren ():
            self.visit (child)

        self.writeln ('}')
        self.writeln ()

    def visit_entity(self): # let's just hardcode this class
        classname = "entity"
        namespace = self.current_namespace
        def helper(name, prefix):
            self.writeln ('[CCode (cname = "%s_%s_%s_%s")]' %
                          (namespace, classname, prefix, name))
            self.writeln ('public int %s_%s_array(int item, char[]? str);' %
                          (prefix, name))
            self.writeln ('[CCode (cname = "%s_%s_%s_%s_wrapper")]' %
                          (namespace, classname, prefix, name))
            self.writeln ('public string %s_%s(int item) {' % (prefix, name))
            self.incr ()
            self.writeln ('int size = %s_%s_array(item, null);' % (prefix, name))
            self.writeln ('char[] buf = new char[size+1];')
            self.writeln ('%s_%s_array(item, buf);' % (prefix, name))
            self.writeln ('return (string) buf;')
            self.decr ()
            self.writeln ('}')

        self.writeln ('[Compact]')
        self.writeln ('public class Entity {')
        self.incr ()
        self.writeln ('public int ext_attributes_size();')
        helper ("name", "ext_attribute")
        helper ("value", "ext_attribute")
        self.writeln ('public int ext_elements_size();')
        helper ("name", "ext_element")
        helper ("value", "ext_element")
        self.decr ()
        self.writeln ('}')
        self.writeln ()

if __name__ == "__main__":
    v = XMLVisitor()
    v.process()
