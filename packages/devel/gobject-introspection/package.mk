PKG_NAME="gobject-introspection"
PKG_VERSION="1.52.1"
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://github.com/GNOME/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib qemu:host gobject-introspection:host"
PKG_DEPENDS_HOST="glib:host"
PKG_SECTION="devel"
PKG_SHORTDESC="glib: C support library"
PKG_LONGDESC="GLib is a library which includes support routines for C such as lists, trees, hashes, memory allocation, and many other things."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="--disable-doctool"

PKG_CONFIGURE_OPTS_TARGET="--disable-doctool"

post_unpack() {
  rm -f $PKG_BUILD/gtk-doc.make
  cat > $PKG_BUILD/gtk-doc.make <<EOF
EXTRA_DIST =
CLEANFILES =
EOF
}

pre_configure_host() {
  CFLAGS="$CFLAGS -fPIC"
}

pre_configure_target() {
  PYTHON_INCLUDES="-I$SYSROOT_PREFIX/usr/include/python2.7"
  CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python2.7"
  CFLAGS="$CFLAGS -fPIC"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=/usr/lib/ld-$(get_pkg_version glibc).so"

cat > $TOOLCHAIN/bin/g-ir-scanner-wrapper << EOF
#!/bin/sh
env LD_LIBRARY_PATH=$PKG_BUILD/.$TARGET_NAME/.libs:$SYSROOT_PREFIX/usr/lib:$SYSROOT_PREFIX/../lib \
    GI_CROSS_LAUNCHER="$TOOLCHAIN/bin/qemu-$TARGET_ARCH -L $SYSROOT_PREFIX" \
    GI_LDD=$TOOLCHAIN/bin/ldd-cross \
    $TOOLCHAIN/bin/g-ir-scanner "\$@"
EOF

  chmod +x $TOOLCHAIN/bin/g-ir-scanner-wrapper

cat > $TOOLCHAIN/bin/g-ir-compiler-wrapper << EOF
#!/bin/sh
env LD_LIBRARY_PATH=$PKG_BUILD/.$TARGET_NAME/.libs:$SYSROOT_PREFIX/usr/lib:$SYSROOT_PREFIX/../lib \
    GI_CROSS_LAUNCHER="$TOOLCHAIN/bin/qemu-$TARGET_ARCH -L $SYSROOT_PREFIX" \
    GI_LDD=$TOOLCHAIN/bin/ldd-cross \
    $TOOLCHAIN/bin/g-ir-compiler "\$@"
EOF

  chmod +x $TOOLCHAIN/bin/g-ir-compiler-wrapper

cat > $TOOLCHAIN/bin/ldd-cross << EOF
#!/bin/sh
$TOOLCHAIN/bin/qemu-$TARGET_ARCH $SYSROOT_PREFIX/usr/lib/ld-$(get_pkg_version glibc).so --list "\$1"
EOF

  chmod +x $TOOLCHAIN/bin/ldd-cross
}

make_target() {
  ##GI_SCANNER_DEBUG="save-temps" \
  GI_CROSS_LAUNCHER="$TOOLCHAIN/bin/qemu-$TARGET_ARCH" \
  GI_LDD=$TOOLCHAIN/bin/ldd-cross \
  INTROSPECTION_SCANNER=$TOOLCHAIN/bin/g-ir-scanner-wrapper \
  INTROSPECTION_COMPILER=$TOOLCHAIN/bin/g-ir-compiler-wrapper \
  make
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/gobject-introspection
  rm -rf $INSTALL/usr/share
}
