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

PKG_NAME="polkit"
PKG_VERSION="0.113"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/polkit"
PKG_URL="http://www.freedesktop.org/software/polkit/releases/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain mozjs pam"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="Application development toolkit for controlling system-wide privileges"
PKG_LONGDESC="Application development toolkit for controlling system-wide privileges"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --enable-libsystemd-login=yes \
                           --disable-gtk-doc-html \
                           --with-authfw=pam \
                           --with-os-type=other \
                           --disable-man-pages \
                           --disable-gtk-doc \
                           --disable-introspection"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -lstdc++ -lnspr4"
}
