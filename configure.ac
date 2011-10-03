AC_INIT([riker],[0.1],[calvin.walton@kepstin.ca])

AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([foreign])

AC_PROG_CC
AM_PROG_VALAC

PKG_CHECK_MODULES([GSTREAMER], [gstreamer-0.10 gstreamer-tag-0.10])
AC_SUBST([GSTREAMER_VALAFLAGS], ["--pkg=gstreamer-0.10 --pkg=gstreamer-tag-0.10"])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
