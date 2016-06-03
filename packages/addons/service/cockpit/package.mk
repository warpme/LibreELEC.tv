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

PKG_NAME="cockpit"
PKG_VERSION="0.108"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.cockpit-project.org/"
PKG_URL="https://github.com/cockpit-project/cockpit/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd glib json-glib polkit krb5"
PKG_PRIORITY="optional"
PKG_SECTION="service"
PKG_SHORTDESC="Cockpit is an interactive server admin interface. It is easy to use and very light weight."
PKG_LONGDESC="Cockpit is an interactive server admin interface. It is easy to use and very light weight."
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Cockpit"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REPOVERSION="8.0"

PKG_CONFIGURE_OPTS_TARGET="--bindir=/storage/.kodi/addons/service.cockpit/bin/ \
                           --sbindir=/storage/.kodi/addons/service.cockpit/bin/ \
                           --libdir=/storage/.kodi/addons/service.cockpit/lib/ \
                           --libexecdir=/storage/.kodi/addons/service.cockpit/lib/ \
                           --disable-pcp \
                           --disable-doc \
                           --disable-maintainer-mode"

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
  NOCONFIGURE=1 ./autogen.sh

  export LIBS="-lkrb5 -lkrb5support -lcrypto -lresolv -lssh -ldl -lz"
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $ROOT/$PKG_BUILD/cockpit-bridge $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -P $ROOT/$PKG_BUILD/cockpit-ws $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -P $ROOT/$PKG_BUILD/cockpit-session $ADDON_BUILD/$PKG_ADDON_ID/lib/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/share
    cp -PR $ROOT/$PKG_BUILD/.install/usr/share/* $ADDON_BUILD/$PKG_ADDON_ID/share/
}
