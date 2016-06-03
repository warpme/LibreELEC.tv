################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="pam"
PKG_VERSION="1.2.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL2"
PKG_SITE="http://linux-pam.org"
PKG_URL="http://linux-pam.org/library/Linux-PAM-${PKG_VERSION}.tar.bz2"
PKG_SOURCE_DIR="Linux-PAM-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="PAM (Pluggable Authentication Modules) library"
PKG_LONGDESC="PAM (Pluggable Authentication Modules) library"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --libdir=/usr/lib \
                           --sbindir=/usr/bin"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -ldl"
  export LIBS="-ldl"
}

post_makeinstall_target() {
  rm -rf $INSTALL
}
