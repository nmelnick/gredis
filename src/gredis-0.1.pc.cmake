prefix=@PREFIX@
exec_prefix=@DOLLAR@{prefix}
libdir=@DOLLAR@{prefix}/lib
bindir=@DOLLAR@{prefix}/bin
includedir=@DOLLAR@{prefix}/include

Name: @PKGNAME@-@PKGVERSION@
Description: Redis library for Vala based on hiredis.
Version: @PKGVERSION@
Libs: -L@DOLLAR@{libdir} -l@PKGNAME@-@PKGVERSION@ -levent -lhiredis
Cflags: -I@DOLLAR@{includedir}
Requires: glib-2.0 gobject-2.0 hiredis gee-0.8
