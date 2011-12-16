ACLOCAL_AMFLAGS = -I m4

noinst_HEADERS = store/store.h

noinst_PROGRAMS = tagread
lib_LTLIBRARIES = store/libriker-store.la

AM_VALAFLAGS = $(UNINSTALLED_VALAFLAGS) --vapidir=$(srcdir) --pkg=config
AM_CFLAGS = -DBUILD_SRCDIR="\"$(abs_srcdir)\""

store_libriker_store_la_SOURCES = \
	store/artist_type.vala \
	store/country.vala \
	store/file.vala \
	store/store.vala
store_libriker_store_la_VALAFLAGS = $(AM_VALAFLAGS) $(SQLITE_VALAFLAGS) --header=store/store.h --vapi=store/store.vapi
store_libriker_store_la_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) $(SQLITE_CFLAGS)
store_libriker_store_la_LIBADD = $(GLIB_LIBS) $(SQLITE_LIBS)
store_libriker_store_la_LDFLAGS = -release $(VERSION)

tagread_SOURCES = tagread.vala
tagread_CFLAGS = $(AM_CFLAGS) $(SQLITE_CFLAGS) $(GSTREAMER_CFLAGS) $(MB4_CFLAGS) -I $(srcdir)/store
tagread_VALAFLAGS = $(AM_VALAFLAGS) $(SQLITE_VALAFLAGS) $(GSTREAMER_VALAFLAGS) $(MB4_VALAFLAGS) --vapidir=$(srcdir)/store --pkg=store
tagread_LDADD = $(GSTREAMER_LIBS) $(MB4_LIBS) store/libriker-store.la
