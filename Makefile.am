ACLOCAL_AMFLAGS = -I m4

noinst_HEADERS = store/store.h
noinst_PROGRAMS = tagread add_artist
noinst_LTLIBRARIES = musicbrainz4/libvalamusicbrainz.la
lib_LTLIBRARIES = store/libriker-store.la

AM_VALAFLAGS = \
	$(UNINSTALLED_VALAFLAGS) \
	$(GLIB_VALAFLAGS) \
	--vapidir=$(srcdir) \
	--vapidir=$(srcdir)/store \
	--vapidir=$(srcdir)/musicbrainz4 \
	--pkg=config
AM_CFLAGS = \
	$(GLIB_CFLAGS) \
	-DBUILD_SRCDIR="\"$(abs_srcdir)\"" \
	-I $(srcdir)/store \
	-I $(srcdir)/musicbrainz4
AM_LIBADD = $(GLIB_LIBS)


musicbrainz4_libvalamusicbrainz_la_SOURCES = \
	musicbrainz4/musicbrainz-4.0.vala
musicbrainz4_libvalamusicbrainz_la_VALAFLAGS = \
	$(AM_VALAFLAGS) \
	$(GEE_VALAFLAGS) \
	--header=musicbrainz4/valamusicbrainz.h \
	--vapi=musicbrainz4/valamusicbrainz.vapi \
	--pkg=libmusicbrainz4
musicbrainz4_libvalamusicbrainz_la_CFLAGS = \
	$(AM_CFLAGS) \
	$(GEE_CFLAGS) \
	$(MB4_CFLAGS)
musicbrainz4_libvalamusicbrainz_la_LIBADD = \
	$(AM_LIBADD) \
	$(MB4_LIBS)


store_libriker_store_la_SOURCES = \
	store/artist.vala \
	store/artist_type.vala \
	store/country.vala \
	store/file.vala \
	store/gender.vala \
	store/store.vala
store_libriker_store_la_VALAFLAGS = \
	$(AM_VALAFLAGS) \
	$(SQLITE_VALAFLAGS) \
	--header=store/store.h \
	--vapi=store/store.vapi
store_libriker_store_la_CFLAGS = \
	$(AM_CFLAGS) \
	$(SQLITE_CFLAGS)
store_libriker_store_la_LIBADD = \
	$(AM_LIBADD) \
	$(SQLITE_LIBS)
store_libriker_store_la_LDFLAGS = \
	-release $(VERSION)


tagread_SOURCES = \
	tagread.vala
tagread_CFLAGS = \
	$(AM_CFLAGS) \
	$(GSTREAMER_CFLAGS)
tagread_VALAFLAGS = \
	$(AM_VALAFLAGS) \
	$(GSTREAMER_VALAFLAGS) \
	--pkg=store \
	--pkg=valamusicbrainz
tagread_LDADD = \
	$(AM_LIBADD) \
	$(GSTREAMER_LIBS) \
	store/libriker-store.la \
	musicbrainz4/libvalamusicbrainz.la


add_artist_SOURCES = \
	add_artist.vala
add_artist_VALAFLAGS = \
	$(AM_VALAFLAGS) \
	--pkg=store \
	--pkg=valamusicbrainz
add_artist_LDADD = \
	$(AM_LIBADD) \
	store/libriker-store.la \
	musicbrainz4/libvalamusicbrainz.la
