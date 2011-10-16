[CCode (cheader_filename = "musicbrainz4/mb4_c.h")]
namespace Mb4 {

	[Compact]
	[CCode (free_function = "mb4_alias_delete")]
	public class Alias {
		public Alias clone();
		public int get_locale(char[] str);
		public int get_text(char[] str);
	}
	
	[Compact]
	[CCode (free_function = "mb4_alias_list_delete")]
	public class AliasList {
		public AliasList clone();
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_alias_list_item")]
		public unowned Alias get(int item);
		public int size {
			[CCode (cname = "mb4_alias_list_size")]
			get;
		}
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
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_annotation_list_item")]
		public unowned Annotation get(int item);
		public int size {
			[CCode (cname = "mb4_annotation_list_size")]
			get;
		}
	}

	[Compact]
	[CCode (free_function = "mb4_artist_delete")]
	public class Artist {
		public Artist clone();
		public AliasList? aliaslist { get; }
		public int get_country(char[] str);
		public int get_disambiguation(char[] str);
		public int get_gender(char[] str);
		public int get_id(char[] str);
//		public LabelList? labellist { get; }
//		public Lifespan? lifespan { get; }
		public int get_name(char[] str);
//		public Rating? rating { get; }
//		public RecordingList? recordinglist { get; }
//		public RelationList? relationlist { get; }
//		public ReleaseGroupList? releasegrouplist { get; }
//		public ReleaseList? releaselist { get; }
		public int get_sortname(char[] str);
//		public TagList? taglist { get; }
		public int get_type(char[] str);
//		public UserRating? userrating { get; }
//		public UserTagList? usertaglist { get; }
//		public WorkList? worklist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_artist_list_delete")]
	public class ArtistList {
		public ArtistList clone();
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_annotation_list_item")]
		public unowned Artist get(int item);
		public int size {
			[CCode (cname = "mb4_artist_list_size")]
			get;
		}
	}
	
	[Compact]
	[CCode (free_function = "mb4_attribute_delete")]
	public class Attribute {
		public Attribute clone();
		public int get_text(char[] str);
	}
	
	[Compact]
	[CCode (free_function = "mb4_attribute_list_delete")]
	public class AttributeList {
		public AttributeList clone();
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_attribute_list_item")]
		public unowned Attribute get(int item);
		public int size {
			[CCode (cname = "mb4_attribute_list_size")]
			get;
		}
	}

	[Compact]
	public class Entity {
		public int ext_attributes_size();
		public int ext_attribute_name(int item, char[] str);
		public int ext_attribute_value(int item, char[] str);
		public int ext_elements_size();
		public int ext_elements_name(int item, char[] str);
		public int ext_element_value(int item, char[] str);
	}
}
