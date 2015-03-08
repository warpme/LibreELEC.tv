################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2013 Dag Wieers (dag@wieers.com)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="lighttpd"
PKG_VERSION="1.4.35"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.lighttpd.net"
PKG_URL="http://download.lighttpd.net/lighttpd/releases-1.4.x/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libressl pcre"
PKG_PRIORITY="optional"
PKG_SECTION="debug/tools"
PKG_SHORTDESC=""
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
			   --with-sysroot=$SYSROOT_PREFIX \
			   --with-openssl-libs=$SYSROOT_PREFIX/usr/lib/libssl.so"

pre_configure_target() {
# lighttpd fails to build with GOLD linker on gcc-4.9
  strip_gold

  export PCRECONFIG="$SYSROOT_PREFIX/usr/bin/pcre-config"
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/lighttpd
    cp -rP $PKG_DIR/config/* $INSTALL/usr/share/lighttpd

  mkdir -p $INSTALL/usr/lib/lighttpd
    cp -P $PKG_DIR/scripts/lighttpd-config $INSTALL/usr/lib/lighttpd
}

post_install() {
  add_user www x 80 80 "webserver" "/storage/weewx/public_html" "/bin/sh"
  add_group www 80

  enable_service lighttpd.service
}
