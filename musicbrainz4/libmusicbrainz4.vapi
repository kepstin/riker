[CCode (cheader_filename = "musicbrainz4/mb4_c.h")]
namespace Mb4 {

	[Compact]
	public class Entity {
		public int ext_attributes_size();
		public int ext_attribute_name(int item, char[] str);
		public int ext_attribute_value(int item, char[] str);
		public int ext_elements_size();
		public int ext_elements_name(int item, char[] str);
		public int ext_element_value(int item, char[] str);
	}
	
	[Compact]
	[CCode (free_function = "mb4_alias_delete")]
	public class Alias {
		public Alias clone();
		public int get_locale(char[] str);
		public int get_text(char[] str);
	}
	
	[Compact]
	[CCode (free_function = "mb4_annotation_delete")]
	public class Annotation {
		public Annotation clone();
		public int get_entity(char[] str);
		public int get_name(char[] str);
		public int get_text(char[] str);
		public int get_type(char[] str);
	}
	
	[Compact]
	[CCode (free_function = "mb4_annotation_list_delete")]
	public class AnnotationList {
		public AnnotationList clone();
		public int get_count();
		public int get_offset();
		public unowned Annotation item(int item);
		public int size();
	}
}
