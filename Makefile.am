ACLOCAL_AMFLAGS = -I m4

noinst_PROGRAMS = tagread
lib_LTLIBRARIES = store/libriker-store.la libmb_ws2/libmb_ws2.la

store_libriker_store_la_SOURCES = \
	store/file.vala \
	store/store.vala
store_libriker_store_la_VALAFLAGS = $(SQLITE_VALAFLAGS) --header=store/store.h --vapi=store/store.vapi
store_libriker_store_la_CFLAGS = $(GLIB_CFLAGS) $(SQLITE_CFLAGS)
store_libriker_store_la_LIBADD = $(GLIB_LIBS) $(SQLITE_LIBS)
store_libriker_store_la_LDFLAGS = -release $(VERSION)

libmb_ws2_libmb_ws2_la_SOURCES = \
	libmb_ws2/alias.vala \
	libmb_ws2/artist.vala \
	libmb_ws2/artist_credit.vala \
	libmb_ws2/attribute.vala \
	libmb_ws2/disc.vala \
	libmb_ws2/isrc.vala \
	libmb_ws2/label.vala \
	libmb_ws2/label_info.vala \
	libmb_ws2/lifespan.vala \
	libmb_ws2/metadata.vala \
	libmb_ws2/name_credit.vala \
	libmb_ws2/puid.vala \
	libmb_ws2/query.vala \
	libmb_ws2/rating.vala \
	libmb_ws2/recording.vala \
	libmb_ws2/relation.vala \
	libmb_ws2/release.vala \
	libmb_ws2/release_group.vala \
	libmb_ws2/tag.vala \
	libmb_ws2/user_rating.vala \
	libmb_ws2/user_tag.vala
libmb_ws2_libmb_ws2_la_VALAFLAGS = $(GEE_VALAFLAGS) --header=libmb_ws2/libmb_ws2.h --vapi=libmb_ws2/libmb_ws2.vapi
libmb_ws2_libmb_ws2_la_CFLAGS = $(GLIB_CFLAGS) $(GEE_CFLAGS)
libmb_ws2_libmb_ws2_la_LIBADD = $(GLIB_LIBS) $(GEE_LIBS)
libmb_ws2_libmb_ws2_la_LDFLAGS = -version-info 0:0:0

tagread_SOURCES = tagread.vala
tagread_CFLAGS = $(GSTREAMER_CFLAGS) $(MB4_CFLAGS) -I store
tagread_VALAFLAGS = $(GSTREAMER_VALAFLAGS) $(MB4_VALAFLAGS) --vapidir=store --pkg=store
tagread_LDADD = $(GSTREAMER_LIBS) $(MB4_LIBS) store/libriker-store.la
