AC_INIT([riker],[0.1],[calvin.walton@kepstin.ca])

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([foreign subdir-objects dist-xz])

LT_INIT([disable-static])

AC_ARG_ENABLE([uninstalled],
	[Support executing the program from the build directory],
	[AC_SUBST([UNINSTALLED_VALAFLAGS], ["-D ENABLE_UNINSTALLED"])])

AM_PROG_VALAC

PKG_CHECK_MODULES([GLIB], [glib-2.0])

PKG_CHECK_MODULES([GSTREAMER], [gstreamer-0.10 gstreamer-tag-0.10])
AC_SUBST([GSTREAMER_VALAFLAGS], ["--pkg=gstreamer-0.10 --pkg=gstreamer-tag-0.10"])

PKG_CHECK_MODULES([SQLITE], [sqlite3])
AC_SUBST([SQLITE_VALAFLAGS], ["--pkg=sqlite3"])

PKG_CHECK_MODULES([GEE], [gee-1.0])
AC_SUBST([GEE_VALAFLAGS], ["--pkg=gee-1.0"])

PKG_CHECK_MODULES([MB4], [libmusicbrainz4])
AC_SUBST([MB4_VALAFLAGS], ['--vapidir=$(srcdir)/musicbrainz4 --pkg=libmusicbrainz4'])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
