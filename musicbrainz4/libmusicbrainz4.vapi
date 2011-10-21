[CCode (cheader_filename = "musicbrainz4/mb4_c.h")]
namespace Mb4 {

	[Compact]
	public class Entity {
		public int ext_attributes_size();
		[CCode (cname = "mb4_entity_ext_attribute_name")]
		public int ext_attribute_name_array(int item, char[]? str);
		[CCode (cname = "mb4_entity_ext_attribute_name_wrapper")]
		public string ext_attribute_name(int item) {
			int size = ext_attribute_name_array(item, null);
			char[] buf = new char[size];
			ext_attribute_name_array(item, buf);
			return (string) buf;
		}
		[CCode (cname = "mb4_entity_ext_attribute_name")]
		public int ext_attribute_value_array(int item, char[]? str);
		[CCode (cname = "mb4_entity_ext_attribute_name_wrapper")]
		public string ext_attribute_value(int item) {
			int size = ext_attribute_value_array(item, null);
			char[] buf = new char[size];
			ext_attribute_value_array(item, buf);
			return (string) buf;
		}
		public int ext_elements_size();
		[CCode (cname = "mb4_entity_ext_element_name")]
		public int ext_element_name_array(int item, char[]? str);
		[CCode (cname = "mb4_entity_ext_element_name_wrapper")]
		public string ext_element_name(int item) {
			int size = ext_element_name_array(item, null);
			char[] buf = new char[size];
			ext_element_name_array(item, buf);
			return (string) buf;
		}
		[CCode (cname = "mb4_entity_ext_element_value")]
		public int ext_element_value_array(int item, char[]? str);
		[CCode (cname = "mb4_entity_ext_element_value_wrapper")]
		public string ext_element_value(int item) {
			int size = ext_element_value_array(item, null);
			char[] buf = new char[size];
			ext_element_value_array(item, buf);
			return (string) buf;
		}
	}

	[Compact]
	[CCode (free_function = "mb4_alias_delete")]
	public class Alias: Entity {
		public Alias clone();
		[CCode (cname = "mb4_alias_get_locale")]
		public int get_locale_array(char[]? str);
		public string locale {
			[CCode (cname = "mb4_alias_get_locale_wrapper")]
			owned get {
				int size = get_locale_array(null);
				char[] buf = new char[size];
				get_locale_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_alias_get_text")]
		public int get_text_array(char[]? str);
		public string text {
			[CCode (cname = "mb4_alias_get_text_wrapper")]
			owned get {
				int size = get_text_array(null);
				char[] buf = new char[size];
				get_text_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_annotation_delete")]
	public class Annotation: Entity {
		public Annotation clone();
		[CCode (cname = "mb4_annotation_get_type")]
		public int get_type_array(char[]? str);
		public string type {
			[CCode (cname = "mb4_annotation_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size];
				get_type_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_annotation_get_entity")]
		public int get_entity_array(char[]? str);
		public string entity {
			[CCode (cname = "mb4_annotation_get_entity_wrapper")]
			owned get {
				int size = get_entity_array(null);
				char[] buf = new char[size];
				get_entity_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_annotation_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_annotation_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size];
				get_name_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_annotation_get_text")]
		public int get_text_array(char[]? str);
		public string text {
			[CCode (cname = "mb4_annotation_get_text_wrapper")]
			owned get {
				int size = get_text_array(null);
				char[] buf = new char[size];
				get_text_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_artist_delete")]
	public class Artist: Entity {
		public Artist clone();
		[CCode (cname = "mb4_artist_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_artist_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_artist_get_type")]
		public int get_type_array(char[]? str);
		public string type {
			[CCode (cname = "mb4_artist_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size];
				get_type_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_artist_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_artist_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size];
				get_name_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_artist_get_sortname")]
		public int get_sortname_array(char[]? str);
		public string sortname {
			[CCode (cname = "mb4_artist_get_sortname_wrapper")]
			owned get {
				int size = get_sortname_array(null);
				char[] buf = new char[size];
				get_sortname_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_artist_get_gender")]
		public int get_gender_array(char[]? str);
		public string gender {
			[CCode (cname = "mb4_artist_get_gender_wrapper")]
			owned get {
				int size = get_gender_array(null);
				char[] buf = new char[size];
				get_gender_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_artist_get_country")]
		public int get_country_array(char[]? str);
		public string country {
			[CCode (cname = "mb4_artist_get_country_wrapper")]
			owned get {
				int size = get_country_array(null);
				char[] buf = new char[size];
				get_country_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_artist_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);
		public string disambiguation {
			[CCode (cname = "mb4_artist_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}
		public Lifespan? lifespan { get; }
		public AliasList? aliaslist { get; }
		public RecordingList? recordinglist { get; }
		public ReleaseList? releaselist { get; }
		public ReleaseGroupList? releasegrouplist { get; }
		public LabelList? labellist { get; }
		public WorkList? worklist { get; }
		public RelationList? relationlist { get; }
		public TagList? taglist { get; }
		public UserTagList? usertaglist { get; }
		public Rating? rating { get; }
		public UserRating? userrating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_artistcredit_delete", lower_case_cprefix="mb4_artistcredit_")]
	public class ArtistCredit: Entity {
		public ArtistCredit clone();
		public NameCreditList namecreditlist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_attribute_delete")]
	public class Attribute: Entity {
		public Attribute clone();
		[CCode (cname = "mb4_attribute_get_text")]
		public int get_text_array(char[]? str);
		public string text {
			[CCode (cname = "mb4_attribute_get_text_wrapper")]
			owned get {
				int size = get_text_array(null);
				char[] buf = new char[size];
				get_text_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_cdstub_delete", lower_case_cprefix="mb4_cdstub_")]
	public class CDStub: Entity {
		public CDStub clone();
		[CCode (cname = "mb4_cdstub_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_cdstub_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_cdstub_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_cdstub_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size];
				get_title_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_cdstub_get_artist")]
		public int get_artist_array(char[]? str);
		public string artist {
			[CCode (cname = "mb4_cdstub_get_artist_wrapper")]
			owned get {
				int size = get_artist_array(null);
				char[] buf = new char[size];
				get_artist_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_cdstub_get_barcode")]
		public int get_barcode_array(char[]? str);
		public string barcode {
			[CCode (cname = "mb4_cdstub_get_barcode_wrapper")]
			owned get {
				int size = get_barcode_array(null);
				char[] buf = new char[size];
				get_barcode_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_cdstub_get_comment")]
		public int get_comment_array(char[]? str);
		public string comment {
			[CCode (cname = "mb4_cdstub_get_comment_wrapper")]
			owned get {
				int size = get_comment_array(null);
				char[] buf = new char[size];
				get_comment_array(buf);
				return (string) buf;
			}
		}
		public NonMBTrackList nonmbtracklist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_collection_delete")]
	public class Collection: Entity {
		public Collection clone();
		[CCode (cname = "mb4_collection_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_collection_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_collection_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_collection_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size];
				get_name_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_collection_get_editor")]
		public int get_editor_array(char[]? str);
		public string editor {
			[CCode (cname = "mb4_collection_get_editor_wrapper")]
			owned get {
				int size = get_editor_array(null);
				char[] buf = new char[size];
				get_editor_array(buf);
				return (string) buf;
			}
		}
		public ReleaseList? releaselist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_disc_delete")]
	public class Disc: Entity {
		public Disc clone();
		[CCode (cname = "mb4_disc_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_disc_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		public int sectors { get; }
		public ReleaseList? releaselist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_freedbdisc_delete", lower_case_cprefix="mb4_freedbdisc_")]
	public class FreeDBDisc: Entity {
		public FreeDBDisc clone();
		[CCode (cname = "mb4_freedbdisc_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_freedbdisc_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_freedbdisc_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_freedbdisc_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size];
				get_title_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_freedbdisc_get_artist")]
		public int get_artist_array(char[]? str);
		public string artist {
			[CCode (cname = "mb4_freedbdisc_get_artist_wrapper")]
			owned get {
				int size = get_artist_array(null);
				char[] buf = new char[size];
				get_artist_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_freedbdisc_get_category")]
		public int get_category_array(char[]? str);
		public string category {
			[CCode (cname = "mb4_freedbdisc_get_category_wrapper")]
			owned get {
				int size = get_category_array(null);
				char[] buf = new char[size];
				get_category_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_freedbdisc_get_year")]
		public int get_year_array(char[]? str);
		public string year {
			[CCode (cname = "mb4_freedbdisc_get_year_wrapper")]
			owned get {
				int size = get_year_array(null);
				char[] buf = new char[size];
				get_year_array(buf);
				return (string) buf;
			}
		}
		public NonMBTrackList? nonmbtracklist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_isrc_delete")]
	public class ISRC: Entity {
		public ISRC clone();
		[CCode (cname = "mb4_isrc_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_isrc_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		public RecordingList? recordinglist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_label_delete")]
	public class Label: Entity {
		public Label clone();
		[CCode (cname = "mb4_label_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_label_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_label_get_type")]
		public int get_type_array(char[]? str);
		public string type {
			[CCode (cname = "mb4_label_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size];
				get_type_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_label_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_label_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size];
				get_name_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_label_get_sortname")]
		public int get_sortname_array(char[]? str);
		public string sortname {
			[CCode (cname = "mb4_label_get_sortname_wrapper")]
			owned get {
				int size = get_sortname_array(null);
				char[] buf = new char[size];
				get_sortname_array(buf);
				return (string) buf;
			}
		}
		public int labelcode { get; }
		[CCode (cname = "mb4_label_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);
		public string disambiguation {
			[CCode (cname = "mb4_label_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_label_get_country")]
		public int get_country_array(char[]? str);
		public string country {
			[CCode (cname = "mb4_label_get_country_wrapper")]
			owned get {
				int size = get_country_array(null);
				char[] buf = new char[size];
				get_country_array(buf);
				return (string) buf;
			}
		}
		public Lifespan? lifespan { get; }
		public AliasList? aliaslist { get; }
		public ReleaseList? releaselist { get; }
		public RelationList? relationlist { get; }
		public TagList? taglist { get; }
		public UserTagList? usertaglist { get; }
		public Rating? rating { get; }
		public UserRating? userrating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_labelinfo_delete", lower_case_cprefix="mb4_labelinfo_")]
	public class LabelInfo: Entity {
		public LabelInfo clone();
		[CCode (cname = "mb4_labelinfo_get_catalognumber")]
		public int get_catalognumber_array(char[]? str);
		public string catalognumber {
			[CCode (cname = "mb4_labelinfo_get_catalognumber_wrapper")]
			owned get {
				int size = get_catalognumber_array(null);
				char[] buf = new char[size];
				get_catalognumber_array(buf);
				return (string) buf;
			}
		}
		public Label? label { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_lifespan_delete")]
	public class Lifespan: Entity {
		public Lifespan clone();
		[CCode (cname = "mb4_lifespan_get_begin")]
		public int get_begin_array(char[]? str);
		public string begin {
			[CCode (cname = "mb4_lifespan_get_begin_wrapper")]
			owned get {
				int size = get_begin_array(null);
				char[] buf = new char[size];
				get_begin_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_lifespan_get_end")]
		public int get_end_array(char[]? str);
		public string end {
			[CCode (cname = "mb4_lifespan_get_end_wrapper")]
			owned get {
				int size = get_end_array(null);
				char[] buf = new char[size];
				get_end_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_medium_delete")]
	public class Medium: Entity {
		public Medium clone();
		[CCode (cname = "mb4_medium_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_medium_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size];
				get_title_array(buf);
				return (string) buf;
			}
		}
		public int position { get; }
		[CCode (cname = "mb4_medium_get_format")]
		public int get_format_array(char[]? str);
		public string format {
			[CCode (cname = "mb4_medium_get_format_wrapper")]
			owned get {
				int size = get_format_array(null);
				char[] buf = new char[size];
				get_format_array(buf);
				return (string) buf;
			}
		}
		public DiscList? disclist { get; }
		public TrackList? tracklist { get; }
		public bool contains_discid(string discid);
	}

	[Compact]
	[CCode (free_function = "mb4_message_delete")]
	public class Message: Entity {
		public Message clone();
		[CCode (cname = "mb4_message_get_text")]
		public int get_text_array(char[]? str);
		public string text {
			[CCode (cname = "mb4_message_get_text_wrapper")]
			owned get {
				int size = get_text_array(null);
				char[] buf = new char[size];
				get_text_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_metadata_delete")]
	public class Metadata: Entity {
		public Metadata clone();
		[CCode (cname = "mb4_metadata_get_xmlns")]
		public int get_xmlns_array(char[]? str);
		public string xmlns {
			[CCode (cname = "mb4_metadata_get_xmlns_wrapper")]
			owned get {
				int size = get_xmlns_array(null);
				char[] buf = new char[size];
				get_xmlns_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_metadata_get_xmlnsext")]
		public int get_xmlnsext_array(char[]? str);
		public string xmlnsext {
			[CCode (cname = "mb4_metadata_get_xmlnsext_wrapper")]
			owned get {
				int size = get_xmlnsext_array(null);
				char[] buf = new char[size];
				get_xmlnsext_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_metadata_get_generator")]
		public int get_generator_array(char[]? str);
		public string generator {
			[CCode (cname = "mb4_metadata_get_generator_wrapper")]
			owned get {
				int size = get_generator_array(null);
				char[] buf = new char[size];
				get_generator_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_metadata_get_created")]
		public int get_created_array(char[]? str);
		public string created {
			[CCode (cname = "mb4_metadata_get_created_wrapper")]
			owned get {
				int size = get_created_array(null);
				char[] buf = new char[size];
				get_created_array(buf);
				return (string) buf;
			}
		}
		public Artist? artist { get; }
		public Release? release { get; }
		public ReleaseGroup? releasegroup { get; }
		public Recording? recording { get; }
		public Label? label { get; }
		public Work? work { get; }
		public PUID? puid { get; }
		public ISRC? isrc { get; }
		public Disc? disc { get; }
		public LabelInfoList? labelinfolist { get; }
		public Rating? rating { get; }
		public UserRating? userrating { get; }
		public Collection? collection { get; }
		public ArtistList? artistlist { get; }
		public ReleaseList? releaselist { get; }
		public ReleaseGroupList? releasegrouplist { get; }
		public RecordingList? recordinglist { get; }
		public LabelList? labellist { get; }
		public WorkList? worklist { get; }
		public ISRCList? isrclist { get; }
		public AnnotationList? annotationlist { get; }
		public CDStubList? cdstublist { get; }
		public FreeDBDiscList? freedbdisclist { get; }
		public TagList? taglist { get; }
		public UserTagList? usertaglist { get; }
		public CollectionList? collectionlist { get; }
		public CDStub? cdstub { get; }
		public Message? message { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_namecredit_delete", lower_case_cprefix="mb4_namecredit_")]
	public class NameCredit: Entity {
		public NameCredit clone();
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
	[CCode (free_function = "mb4_query_delete")]
	public class Query {
		public Query(string user_agent, string? server, int port);
		public Query clone();
		public int lasthttpcode { get; }
		[CCode (cname = "mb4_query_get_lasterrormessage")]
		public int get_lasterrormessage_array(char[]? str);
		public string lasterrormessage {
			[CCode (cname = "mb4_query_get_lasterrormessage_wrapper")]
			owned get {
				int size = get_lasterrormessage_array(null);
				char[] buf = new char[size];
				get_lasterrormessage_array(buf);
				return (string) buf;
			}
		}
		public string username { set; }
		public string password { set; }
		public string proxyhost { set; }
		public int proxyport { set; }
		public string proxyusername { set; }
		public string proxypassword { set; }
		public ReleaseList lookup_discid(string disc_id);
	}
	
	[Compact]
	[CCode (free_function = "mb4_release_list_delete")]
	public class ReleaseList: Entity {
	}
	
	[Compact]
	[CCode (free_function = "mb4_alias_list_delete")]
	public class AliasList: Entity {
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
	public class RecordingList {}
	[Compact]
	public class ReleaseGroupList {}
	[Compact]
	public class LabelList {}
	[Compact]
	public class WorkList {}
	[Compact]
	public class RelationList {}
	[Compact]
	public class TagList {}
	[Compact]
	public class UserTagList {}
	[Compact]
	public class Rating {}
	[Compact]
	public class UserRating {}
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
	public class NameCreditList {}
	[Compact]
	public class NonMBTrackList {}
	[Compact]
	public class DiscList {}
	[Compact]
	public class TrackList {}
	[Compact]
	public class Release {}
	[Compact]
	public class ReleaseGroup {}
	[Compact]
	public class Recording {}
	[Compact]
	public class Work {}
	[Compact]
	public class PUID {}
	[Compact]
	public class LabelInfoList {}
	[Compact]
	public class ISRCList {}
	[Compact]
	public class CDStubList {}
	[Compact]
	public class FreeDBDiscList {}
	[Compact]
	public class CollectionList {}
}
