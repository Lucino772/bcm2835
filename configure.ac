dnl -*-autoconf-*-
dnl bcm2835: Autoconf script
dnl 
dnl $Id: configure.in,v 1.1 2012/12/01 22:56:52 mikem Exp mikem $
dnl (C) 2012 Mike McCauley (mikem@airspayce.com)

dnl Dont forget to update  BCM2835_VERSION and .tar.gz in bcm2835.h
dnl and the zip file.
AC_INIT([bcm2835], [1.75], [mikem@airspayce.com])

AC_CONFIG_HEADERS(config.h:config.h.in)
AM_INIT_AUTOMAKE()
AC_CHECK_LIB([rt], [clock_gettime])
AC_MSG_CHECKING([for docs])
AC_ARG_WITH([docs],
   [AS_HELP_STRING([--with-docs], [generate doxygen docs (default yes)])],
   [with_docs=$withval],
   [with_docs=yes])
AC_MSG_RESULT([$with_docs])
AM_CONDITIONAL([HAVE_DOCS], [test "x$with_docs" = "xyes"])
if test "x$with_docs" = "xyes" ; then
   AC_CHECK_PROGS([DOXYGEN], [doxygen])
   if test -z "$DOXYGEN";
      then AC_MSG_WARN([Doxygen not found - continuing without Doxygen support])
   fi
fi
AC_PROG_RANLIB
AC_PROG_CC
AC_CONFIG_MACRO_DIR([m4])
AM_CONDITIONAL([HAVE_DOXYGEN], [test -n "$DOXYGEN"])
AM_COND_IF([HAVE_DOXYGEN], [AC_CONFIG_FILES([doc/Doxyfile])])
AC_CONFIG_FILES(Makefile src/Makefile doc/Makefile)
AC_OUTPUT
