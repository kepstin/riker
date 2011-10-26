/*
 * Vala bindings for libmusicbrainz4 - Client library to access MusicBrainz
 * Copyright © 2011 Calvin Walton
 * Based on code Copyright (C) 2011 Andrew Hawkins
 *
 * This file is part of the Riker music player project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
[CCode (cheader_filename = "musicbrainz4/mb4_c.h")]
namespace Mb4 {

	[Compact]
	public class Entity {
		/**
		 * Get the number of extension attributes for the entry.
		 * @return The number of extension attributes.
		 */
		public int ext_attributes_size();

		/**
		 * Get the name of the requested extension attribute.
		 * @param item Item to return.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_entity_ext_attribute_name")]
		public int ext_attribute_name_array(int item, char[]? str);

		/**
		 * Get the name of the requested extension attribute.
		 * @param item Item to return.
		 * @return The name of the requested extension attribute.
		 */
		[CCode (cname = "mb4_entity_ext_attribute_name_wrapper")]
		public string ext_attribute_name(int item) {
			int size = ext_attribute_name_array(item, null);
			char[] buf = new char[size+1];
			ext_attribute_name_array(item, buf);
			return (string) buf;
		}

		/**
		 * Get the value of the requested extension attribute.
		 * @param item Item to return.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_entity_ext_attribute_value")]
		public int ext_attribute_value_array(int item, char[]? str);

		/**
		 * Get the value of the requested extension attribute.
		 * @param item Item to return.
		 * @return The value of the requested extension attribute.
		 */
		[CCode (cname = "mb4_entity_ext_attribute_value_wrapper")]
		public string ext_attribute_value(int item) {
			int size = ext_attribute_value_array(item, null);
			char[] buf = new char[size+1];
			ext_attribute_value_array(item, buf);
			return (string) buf;
		}

		/**
		 * Get the number of extension elements for the entity.
		 * @return The number of extension elements.
		 */
		public int ext_elements_size();

		/**
		 * Get the name of the requested extension element.
		 * @param item Item to return.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_entity_ext_element_name")]
		public int ext_element_name_array(int item, char[]? str);

		/**
		 * Get the name of the requested extension element.
		 * @param item Item to return.
		 * @return The name of the requested extension element.
		 */
		[CCode (cname = "mb4_entity_ext_element_name_wrapper")]
		public string ext_element_name(int item) {
			int size = ext_element_name_array(item, null);
			char[] buf = new char[size+1];
			ext_element_name_array(item, buf);
			return (string) buf;
		}

		/**
		 * Get the value of the requested extension element.
		 * @param item Item to return.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_entity_ext_element_value")]
		public int ext_element_value_array(int item, char[]? str);

		/**
		 * Get the value of the requested extension element.
		 * @param item Item to return.
		 * @return The value of the requested extension element.
		 */
		[CCode (cname = "mb4_entity_ext_element_value_wrapper")]
		public string ext_element_value(int item) {
			int size = ext_element_value_array(item, null);
			char[] buf = new char[size+1];
			ext_element_value_array(item, buf);
			return (string) buf;
		}
	}

	/**
	 * A variant name primarily used as a search help.
	 *
	 * See [http://musicbrainz.org/doc/Aliases|Aliases]
	 */
	[Compact]
	[CCode (free_function = "mb4_alias_delete")]
	public class Alias: Entity {
		/**
		 * Create a copy of an Alias object.
		 * @alias Object to copy.
		 */
		[CCode (cname = "mb4_alias_clone")]
		public Alias.copy(Alias alias);

		/**
		 * Get the Alias locale (Country + Language/Script).
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_alias_get_locale")]
		public int get_locale_array(char[]? str);

		/**
		 * The Alias locale (Country + Language/Script).
		 */
		public string locale {
			[CCode (cname = "mb4_alias_get_locale_wrapper")]
			owned get {
				int size = get_locale_array(null);
				char[] buf = new char[size+1];
				get_locale_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the Alias text.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_alias_get_text")]
		public int get_text_array(char[]? str);

		/**
		 * The Alias text.
		 */
		public string text {
			[CCode (cname = "mb4_alias_get_text_wrapper")]
			owned get {
				int size = get_text_array(null);
				char[] buf = new char[size+1];
				get_text_array(buf);
				return (string) buf;
			}
		}
	}

	/**
	 * Text fields, functioning like a miniature wiki, that can be added to
	 * various MusicBrainz entities.
	 *
	 * See [http://musicbrainz.org/doc/Annotation|Annotation]
	 */
	[Compact]
	[CCode (free_function = "mb4_annotation_delete")]
	public class Annotation: Entity {
		/**
		 * Create a copy of an Annotation object.
		 * @annotation Object to copy.
		 */
		[CCode (cname = "mb4_annotation_clone")]
		public Annotation.copy(Annotation annotation);

		/**
		 * Get the type of the entity the Annotation is associated with.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_annotation_get_type")]
		public int get_type_array(char[]? str);

		/**
		 * The type of the entity the Annotation is associated with.
		 */
		public string type {
			[CCode (cname = "mb4_annotation_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size+1];
				get_type_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the MBID of the entity the Annotation is associated with.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_annotation_get_entity")]
		public int get_entity_array(char[]? str);

		/**
		 * The MBID of the entity the Annotation is associated with.
		 */
		public string entity {
			[CCode (cname = "mb4_annotation_get_entity_wrapper")]
			owned get {
				int size = get_entity_array(null);
				char[] buf = new char[size+1];
				get_entity_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the name of the entity the Annotation is associated with.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_annotation_get_name")]
		public int get_name_array(char[]? str);

		/**
		 * The name of the entity the Annotation is associated with.
		 */
		public string name {
			[CCode (cname = "mb4_annotation_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size+1];
				get_name_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the content of the Annotation.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_annotation_get_text")]
		public int get_text_array(char[]? str);

		/**
		 * The content of the Annotation.
		 */
		public string text {
			[CCode (cname = "mb4_annotation_get_text_wrapper")]
			owned get {
				int size = get_text_array(null);
				char[] buf = new char[size+1];
				get_text_array(buf);
				return (string) buf;
			}
		}
	}

	/**
	 * A person, group of people, or other contributor or credited entity
	 * on a musical work.
	 *
	 * See [http://musicbrainz.org/doc/Artist|Artist]
	 */
	[Compact]
	[CCode (free_function = "mb4_artist_delete")]
	public class Artist: Entity {
		/**
		 * Create a copy of an Artist object.
		 * @artist Object to copy.
		 */
		[CCode (cname = "mb4_artist_clone")]
		public Artist.copy(Artist artist);

		/**
		 * Get the MBID of the Artist.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_id")]
		public int get_id_array(char[]? str);

		/**
		 * The MBID of the Artist.
		 *
		 * See [http://musicbrainz.org/doc/MusicBrainz_Identifier|MusicBrainz Identifier]
		 */
		public string id {
			[CCode (cname = "mb4_artist_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size+1];
				get_id_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the type of the Artist.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_type")]
		public int get_type_array(char[]? str);

		/**
		 * The type of the artist.
		 *
		 * See [http://musicbrainz.org/doc/Artist_Type|Artist Type]
		 */
		public string type {
			[CCode (cname = "mb4_artist_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size+1];
				get_type_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the name of the Artist.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_name")]
		public int get_name_array(char[]? str);

		/**
		 * The Artist's name.
		 *
		 * See [http://musicbrainz.org/doc/Artist_Name|Artist Name]
		 */
		public string name {
			[CCode (cname = "mb4_artist_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size+1];
				get_name_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the Artist's sort name.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_sortname")]
		public int get_sortname_array(char[]? str);

		/**
		 * The Artist's sort name.
		 *
		 * See [http://musicbrainz.org/doc/Sort_Name|Sort Name]
		 */
		public string sortname {
			[CCode (cname = "mb4_artist_get_sortname_wrapper")]
			owned get {
				int size = get_sortname_array(null);
				char[] buf = new char[size+1];
				get_sortname_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the Artist's gender.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_gender")]
		public int get_gender_array(char[]? str);

		/**
		 * The Artist's gender.
		 */
		public string gender {
			[CCode (cname = "mb4_artist_get_gender_wrapper")]
			owned get {
				int size = get_gender_array(null);
				char[] buf = new char[size+1];
				get_gender_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the Artist's country.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_country")]
		public int get_country_array(char[]? str);

		/**
		 * The Artist's country.
		 *
		 * This will be one of the ISO codes from [http://musicbrainz.org/doc/Release_Country|Release Country]
		 */
		public string country {
			[CCode (cname = "mb4_artist_get_country_wrapper")]
			owned get {
				int size = get_country_array(null);
				char[] buf = new char[size+1];
				get_country_array(buf);
				return (string) buf;
			}
		}

		/**
		 * Get the disambiguation comment for the Artist.
		 * @param str Array to fill with returned string, or null to find length only.
		 * @return The number of characters in the string to copy (not including terminating null).
		 */
		[CCode (cname = "mb4_artist_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);

		/**
		 * The disambiguation comment for the artist.
		 *
		 * See [http://musicbrainz.org/doc/Disambiguation_Comment|Disambiguation Comment]
		 */
		public string disambiguation {
			[CCode (cname = "mb4_artist_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}

		/**
		 * The lifespan (begin/end dates) of the Artist.
		 */
		public Lifespan? lifespan { get; }

		/**
		 * A list of {@link Alias}es for the Artist.
		 */
		public AliasList? aliaslist { get; }

		/**
		 * A list of {@link Recording}s by the Artist.
		 */
		public RecordingList? recordinglist { get; }

		/**
		 * A list of {@link Release}s by the Artist.
		 */
		public ReleaseList? releaselist { get; }

		/**
		 * A list of {@link ReleaseGroup}s by the Artist.
		 */
		public ReleaseGroupList? releasegrouplist { get; }

		/**
		 * A list of {@link Label}s associated with the Artist.
		 *
		 * It's unknown what this field is for, and it appears to be unused.
		 */
		public LabelList? labellist { get; }

		/**
		 * A list of {@link Work}s to which this Artist contributed.
		 */
		public WorkList? worklist { get; }

		/**
		 * A list of {@link Relation}s linking to this Artist.
		 */
		public RelationList? relationlist { get; }

		/**
		 * A list of {@link Tag}s applied to this Artist.
		 */
		public TagList? taglist { get; }

		/**
		 * A list of {@link UserTag}s applied to this Artist by the current User.
		 */
		public UserTagList? usertaglist { get; }

		/**
		 * The overall {@link Rating} for this Artist.
		 */
		public Rating? rating { get; }

		/**
		 * The {@link UserRating} for this Artist by the current User.
		 */
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
				char[] buf = new char[size+1];
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
		[CCode (cname = "mb4_namecredit_get_joinphrase")]
		public int get_joinphrase_array(char[]? str);
		public string joinphrase {
			[CCode (cname = "mb4_namecredit_get_joinphrase_wrapper")]
			owned get {
				int size = get_joinphrase_array(null);
				char[] buf = new char[size+1];
				get_joinphrase_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_namecredit_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_namecredit_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size+1];
				get_name_array(buf);
				return (string) buf;
			}
		}
		public Artist artist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_nonmbtrack_delete", lower_case_cprefix="mb4_nonmbtrack_")]
	public class NonMBTrack: Entity {
		public NonMBTrack clone();
		[CCode (cname = "mb4_nonmbtrack_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_nonmbtrack_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size+1];
				get_title_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_nonmbtrack_get_artist")]
		public int get_artist_array(char[]? str);
		public string artist {
			[CCode (cname = "mb4_nonmbtrack_get_artist_wrapper")]
			owned get {
				int size = get_artist_array(null);
				char[] buf = new char[size+1];
				get_artist_array(buf);
				return (string) buf;
			}
		}
		public int length { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_puid_delete")]
	public class PUID: Entity {
		public PUID clone();
		[CCode (cname = "mb4_puid_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_puid_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size+1];
				get_id_array(buf);
				return (string) buf;
			}
		}
		public RecordingList? recordinglist { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_query_delete")]
	public class Query {
		public Query clone();
		public int lasthttpcode { get; }
		[CCode (cname = "mb4_query_get_lasterrormessage")]
		public int get_lasterrormessage_array(char[]? str);
		public string lasterrormessage {
			[CCode (cname = "mb4_query_get_lasterrormessage_wrapper")]
			owned get {
				int size = get_lasterrormessage_array(null);
				char[] buf = new char[size+1];
				get_lasterrormessage_array(buf);
				return (string) buf;
			}
		}
		public Query(string user_agent, string? server = null, int port = 0);
		public string username { set; }
		public string password { set; }
		public string proxyhost { set; }
		public int proxyport { set; }
		public string proxyusername { set; }
		public string proxypassword { set; }
		public ReleaseList lookup_discid(string disc_id);
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
		public Result lastresult { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_rating_delete")]
	public class Rating: Entity {
		public Rating clone();
		public int votescount { get; }
		public double rating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_recording_delete")]
	public class Recording: Entity {
		public Recording clone();
		[CCode (cname = "mb4_recording_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_recording_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size+1];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_recording_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_recording_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size+1];
				get_title_array(buf);
				return (string) buf;
			}
		}
		public int length { get; }
		[CCode (cname = "mb4_recording_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);
		public string disambiguation {
			[CCode (cname = "mb4_recording_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size+1];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}
		public ArtistCredit? artistcredit { get; }
		public ReleaseList? releaselist { get; }
		public PUIDList? puidlist { get; }
		public ISRCList? isrclist { get; }
		public RelationList? relationlist { get; }
		public TagList? taglist { get; }
		public UserTagList? usertaglist { get; }
		public Rating? rating { get; }
		public UserRating? userrating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_relation_delete")]
	public class Relation: Entity {
		public Relation clone();
		[CCode (cname = "mb4_relation_get_type")]
		public int get_type_array(char[]? str);
		public string type {
			[CCode (cname = "mb4_relation_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size+1];
				get_type_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_relation_get_target")]
		public int get_target_array(char[]? str);
		public string target {
			[CCode (cname = "mb4_relation_get_target_wrapper")]
			owned get {
				int size = get_target_array(null);
				char[] buf = new char[size+1];
				get_target_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_relation_get_direction")]
		public int get_direction_array(char[]? str);
		public string direction {
			[CCode (cname = "mb4_relation_get_direction_wrapper")]
			owned get {
				int size = get_direction_array(null);
				char[] buf = new char[size+1];
				get_direction_array(buf);
				return (string) buf;
			}
		}
		public AttributeList? attributelist { get; }
		[CCode (cname = "mb4_relation_get_begin")]
		public int get_begin_array(char[]? str);
		public string begin {
			[CCode (cname = "mb4_relation_get_begin_wrapper")]
			owned get {
				int size = get_begin_array(null);
				char[] buf = new char[size+1];
				get_begin_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_relation_get_end")]
		public int get_end_array(char[]? str);
		public string end {
			[CCode (cname = "mb4_relation_get_end_wrapper")]
			owned get {
				int size = get_end_array(null);
				char[] buf = new char[size+1];
				get_end_array(buf);
				return (string) buf;
			}
		}
		public Artist? artist { get; }
		public Release? release { get; }
		public ReleaseGroup? releasegroup { get; }
		public Recording? recording { get; }
		public Label? label { get; }
		public Work? work { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_release_delete")]
	public class Release: Entity {
		public Release clone();
		[CCode (cname = "mb4_release_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_release_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size+1];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_release_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size+1];
				get_title_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_status")]
		public int get_status_array(char[]? str);
		public string status {
			[CCode (cname = "mb4_release_get_status_wrapper")]
			owned get {
				int size = get_status_array(null);
				char[] buf = new char[size+1];
				get_status_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_quality")]
		public int get_quality_array(char[]? str);
		public string quality {
			[CCode (cname = "mb4_release_get_quality_wrapper")]
			owned get {
				int size = get_quality_array(null);
				char[] buf = new char[size+1];
				get_quality_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);
		public string disambiguation {
			[CCode (cname = "mb4_release_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size+1];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_packaging")]
		public int get_packaging_array(char[]? str);
		public string packaging {
			[CCode (cname = "mb4_release_get_packaging_wrapper")]
			owned get {
				int size = get_packaging_array(null);
				char[] buf = new char[size+1];
				get_packaging_array(buf);
				return (string) buf;
			}
		}
		public TextRepresentation? textrepresentation { get; }
		public ArtistCredit? artistcredit { get; }
		public ReleaseGroup? releasegroup { get; }
		[CCode (cname = "mb4_release_get_date")]
		public int get_date_array(char[]? str);
		public string date {
			[CCode (cname = "mb4_release_get_date_wrapper")]
			owned get {
				int size = get_date_array(null);
				char[] buf = new char[size+1];
				get_date_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_country")]
		public int get_country_array(char[]? str);
		public string country {
			[CCode (cname = "mb4_release_get_country_wrapper")]
			owned get {
				int size = get_country_array(null);
				char[] buf = new char[size+1];
				get_country_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_barcode")]
		public int get_barcode_array(char[]? str);
		public string barcode {
			[CCode (cname = "mb4_release_get_barcode_wrapper")]
			owned get {
				int size = get_barcode_array(null);
				char[] buf = new char[size+1];
				get_barcode_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_release_get_asin")]
		public int get_asin_array(char[]? str);
		public string asin {
			[CCode (cname = "mb4_release_get_asin_wrapper")]
			owned get {
				int size = get_asin_array(null);
				char[] buf = new char[size+1];
				get_asin_array(buf);
				return (string) buf;
			}
		}
		public LabelInfoList? labelinfolist { get; }
		public MediumList? mediumlist { get; }
		public RelationList? relationlist { get; }
		public MediumList media_matching_discid(string discid);
	}

	[Compact]
	[CCode (free_function = "mb4_releasegroup_delete", lower_case_cprefix="mb4_releasegroup_")]
	public class ReleaseGroup: Entity {
		public ReleaseGroup clone();
		[CCode (cname = "mb4_releasegroup_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_releasegroup_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size+1];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_releasegroup_get_type")]
		public int get_type_array(char[]? str);
		public string type {
			[CCode (cname = "mb4_releasegroup_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size+1];
				get_type_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_releasegroup_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_releasegroup_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size+1];
				get_title_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_releasegroup_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);
		public string disambiguation {
			[CCode (cname = "mb4_releasegroup_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size+1];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_releasegroup_get_firstreleasedate")]
		public int get_firstreleasedate_array(char[]? str);
		public string firstreleasedate {
			[CCode (cname = "mb4_releasegroup_get_firstreleasedate_wrapper")]
			owned get {
				int size = get_firstreleasedate_array(null);
				char[] buf = new char[size+1];
				get_firstreleasedate_array(buf);
				return (string) buf;
			}
		}
		public ArtistCredit? artistcredit { get; }
		public ReleaseList? releaselist { get; }
		public RelationList? relationlist { get; }
		public TagList? taglist { get; }
		public UserTagList? usertaglist { get; }
		public Rating? rating { get; }
		public UserRating? userrating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_tag_delete")]
	public class Tag: Entity {
		public Tag clone();
		public int count { get; }
		[CCode (cname = "mb4_tag_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_tag_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size+1];
				get_name_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_textrepresentation_delete", lower_case_cprefix="mb4_textrepresentation_")]
	public class TextRepresentation: Entity {
		public TextRepresentation clone();
		[CCode (cname = "mb4_textrepresentation_get_language")]
		public int get_language_array(char[]? str);
		public string language {
			[CCode (cname = "mb4_textrepresentation_get_language_wrapper")]
			owned get {
				int size = get_language_array(null);
				char[] buf = new char[size+1];
				get_language_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_textrepresentation_get_script")]
		public int get_script_array(char[]? str);
		public string script {
			[CCode (cname = "mb4_textrepresentation_get_script_wrapper")]
			owned get {
				int size = get_script_array(null);
				char[] buf = new char[size+1];
				get_script_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_track_delete")]
	public class Track: Entity {
		public Track clone();
		public int position { get; }
		[CCode (cname = "mb4_track_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_track_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size+1];
				get_title_array(buf);
				return (string) buf;
			}
		}
		public Recording? recording { get; }
		public int length { get; }
		public ArtistCredit? artistcredit { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_userrating_delete", lower_case_cprefix="mb4_userrating_")]
	public class UserRating: Entity {
		[CCode (cname = "mb4_userrating_clone")]
		public UserRating.copy(UserRating userrating);
		public int userrating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_usertag_delete", lower_case_cprefix="mb4_usertag_")]
	public class UserTag: Entity {
		[CCode (cname = "mb4_usertag_clone")]
		public UserTag.copy(UserTag usertag);
		[CCode (cname = "mb4_usertag_get_name")]
		public int get_name_array(char[]? str);
		public string name {
			[CCode (cname = "mb4_usertag_get_name_wrapper")]
			owned get {
				int size = get_name_array(null);
				char[] buf = new char[size+1];
				get_name_array(buf);
				return (string) buf;
			}
		}
	}

	[Compact]
	[CCode (free_function = "mb4_work_delete")]
	public class Work: Entity {
		[CCode (cname = "mb4_work_clone")]
		public Work.copy(Work work);
		[CCode (cname = "mb4_work_get_id")]
		public int get_id_array(char[]? str);
		public string id {
			[CCode (cname = "mb4_work_get_id_wrapper")]
			owned get {
				int size = get_id_array(null);
				char[] buf = new char[size+1];
				get_id_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_work_get_type")]
		public int get_type_array(char[]? str);
		public string type {
			[CCode (cname = "mb4_work_get_type_wrapper")]
			owned get {
				int size = get_type_array(null);
				char[] buf = new char[size+1];
				get_type_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_work_get_title")]
		public int get_title_array(char[]? str);
		public string title {
			[CCode (cname = "mb4_work_get_title_wrapper")]
			owned get {
				int size = get_title_array(null);
				char[] buf = new char[size+1];
				get_title_array(buf);
				return (string) buf;
			}
		}
		public ArtistCredit? artistcredit { get; }
		[CCode (cname = "mb4_work_get_iswc")]
		public int get_iswc_array(char[]? str);
		public string iswc {
			[CCode (cname = "mb4_work_get_iswc_wrapper")]
			owned get {
				int size = get_iswc_array(null);
				char[] buf = new char[size+1];
				get_iswc_array(buf);
				return (string) buf;
			}
		}
		[CCode (cname = "mb4_work_get_disambiguation")]
		public int get_disambiguation_array(char[]? str);
		public string disambiguation {
			[CCode (cname = "mb4_work_get_disambiguation_wrapper")]
			owned get {
				int size = get_disambiguation_array(null);
				char[] buf = new char[size+1];
				get_disambiguation_array(buf);
				return (string) buf;
			}
		}
		public AliasList? aliaslist { get; }
		public RelationList? relationlist { get; }
		public TagList? taglist { get; }
		public UserTagList? usertaglist { get; }
		public Rating? rating { get; }
		public UserRating? userrating { get; }
	}

	[Compact]
	[CCode (free_function = "mb4_alias_list_delete")]
	public class AliasList: Entity {
		public int size {
			[CCode (cname = "mb4_alias_list_size")]
			get;
		}
		[CCode (cname = "mb4_alias_list_item")]
		public unowned Alias get(int item);
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_alias_list_clone")]
		public AliasList.copy(AliasList alias_list);
	}

	[Compact]
	[CCode (free_function = "mb4_annotation_list_delete")]
	public class AnnotationList: Entity {
		public int size {
			[CCode (cname = "mb4_annotation_list_size")]
			get;
		}
		[CCode (cname = "mb4_annotation_list_item")]
		public unowned Annotation get(int item);
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_annotation_list_clone")]
		public AnnotationList.copy(AnnotationList annotation_list);
	}

	[Compact]
	[CCode (free_function = "mb4_artist_list_delete")]
	public class ArtistList: Entity {
		public int size {
			[CCode (cname = "mb4_artist_list_size")]
			get;
		}
		[CCode (cname = "mb4_artist_list_item")]
		public unowned Artist get(int item);
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_artist_list_clone")]
		public ArtistList.copy(ArtistList artist_list);
	}

	[Compact]
	[CCode (free_function = "mb4_attribute_list_delete")]
	public class AttributeList: Entity {
		public int size {
			[CCode (cname = "mb4_attribute_list_size")]
			get;
		}
		[CCode (cname = "mb4_attribute_list_item")]
		public unowned Attribute get(int item);
		public int count { get; }
		public int offset { get; }
		[CCode (cname = "mb4_attribute_list_clone")]
		public AttributeList.copy(AttributeList attribute_list);
	}











	[Compact]
	[CCode (free_function = "mb4_release_list_delete")]
	public class ReleaseList: Entity {
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
	public class NameCreditList {}
	[Compact]
	public class NonMBTrackList {}
	[Compact]
	public class DiscList {}
	[Compact]
	public class TrackList {}
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
	[Compact]
	public class PUIDList {}
	[Compact]
	public class MediumList {}
}
