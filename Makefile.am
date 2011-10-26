ACLOCAL_AMFLAGS = -I m4

noinst_HEADERS = store/store.h

noinst_PROGRAMS = tagread
lib_LTLIBRARIES = store/libriker-store.la

store_libriker_store_la_SOURCES = \
	store/file.vala \
	store/store.vala
store_libriker_store_la_VALAFLAGS = $(SQLITE_VALAFLAGS) --header=store/store.h --vapi=store/store.vapi
store_libriker_store_la_CFLAGS = $(GLIB_CFLAGS) $(SQLITE_CFLAGS)
store_libriker_store_la_LIBADD = $(GLIB_LIBS) $(SQLITE_LIBS)
store_libriker_store_la_LDFLAGS = -release $(VERSION)

tagread_SOURCES = tagread.vala
tagread_CFLAGS = $(GSTREAMER_CFLAGS) $(MB4_CFLAGS) -I $(srcdir)/store
tagread_VALAFLAGS = $(GSTREAMER_VALAFLAGS) $(MB4_VALAFLAGS) --vapidir=$(srcdir)/store --pkg=store
tagread_LDADD = $(GSTREAMER_LIBS) $(MB4_LIBS) store/libriker-store.la
