ACLOCAL_AMFLAGS = -I m4

noinst_PROGRAMS = tagread
noinst_LTLIBRARIES = store/libriker-store.la

store_libriker_store_la_SOURCES = store/store.vala
store_libriker_store_la_CFLAGS = $(GLIB_CFLAGS) $(SQLITE_CFLAGS)
store_libriker_store_la_VALAFLAGS = $(SQLITE_VALAFLAGS) --header=store/store.h
store_libriker_store_la_LIBADD = $(GLIB_LIBS) $(SQLITE_LIBS)

tagread_SOURCES = tagread.vala
tagread_CFLAGS = $(GSTREAMER_CFLAGS)
tagread_VALAFLAGS = $(GSTREAMER_VALAFLAGS)
tagread_LDADD = $(GSTREAMER_LIBS) store/libriker-store.la
