AC_INIT([riker],[0.1],[calvin.walton@kepstin.ca])

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([foreign subdir-objects dist-xz])

LT_INIT([disable-static])

# Uninstalled is force-enabled for now
AC_SUBST([UNINSTALLED_VALAFLAGS], ["-D ENABLE_UNINSTALLED"])
#AC_ARG_ENABLE([uninstalled],
#	[Support executing the program from the build directory],
#	[AC_SUBST([UNINSTALLED_VALAFLAGS], ["-D ENABLE_UNINSTALLED"])])

AM_PROG_VALAC([0.15.1])

PKG_CHECK_MODULES([GLIB], [glib-2.0 gio-2.0])
AC_SUBST([GLIB_VALAFLAGS], ["--pkg=gio-2.0"])

PKG_CHECK_MODULES([GSTREAMER], [gstreamer-0.10 gstreamer-tag-0.10])
AC_SUBST([GSTREAMER_VALAFLAGS], ["--pkg=gstreamer-0.10 --pkg=gstreamer-tag-0.10"])

PKG_CHECK_MODULES([SQLITE], [sqlite3])
AC_SUBST([SQLITE_VALAFLAGS], ["--pkg=sqlite3"])

PKG_CHECK_MODULES([GEE], [gee-0.8])
AC_SUBST([GEE_VALAFLAGS], ["--pkg=gee-0.8"])

PKG_CHECK_MODULES([MB4], [libmusicbrainz4])
AC_SUBST([MB4_VALAFLAGS], ['--vapidir=$(srcdir)/musicbrainz4 --pkg=libmusicbrainz4'])

PKG_CHECK_MODULES([GDA], [libgda-5.0 >= 5.1.0 libgdadata-5.0 >= 5.1.0])
AC_SUBST([GDA_VALAFLAGS], ["--pkg=libgda-5.0 --pkg=gdadata-5.0 --pkg=libxml-2.0 --pkg=gee-0.8"])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
