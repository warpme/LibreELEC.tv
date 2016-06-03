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

PKG_NAME="mozjs"
PKG_VERSION="17.0.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MPL"
PKG_SITE="https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Releases/17"
PKG_URL="http://ftp.mozilla.org/pub/mozilla.org/js/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain nspr libffi mozjs:host"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="JavaScript interpreter and libraries (legacy)"
PKG_LONGDESC="JavaScript interpreter and libraries (legacy)"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_SCRIPT="js/src/configure"

PKG_CONFIGURE_OPTS_HOST="--disable-shared-js"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared-js \
                           --with-system-nspr \
                           --with-nspr-prefix=$SYSROOT_PREFIX/usr \
                           --with-system-ffi \
                           --enable-threadsafe"

pre_configure_host() {
  sed -i 's/(defined\((@TEMPLATE_FILE)\))/\1/' $ROOT/$PKG_BUILD/js/src/config/milestone.pl
}

post_makeinstall_host() {
  cp -P host_jskwgen $ROOT/$TOOLCHAIN/bin/
  cp -P host_jsoplengen $ROOT/$TOOLCHAIN/bin/
}

pre_configure_target() {
  strip_lto
  export NSINSTALL_BIN="$ROOT/$TOOLCHAIN/bin/nsinstall"

  sed -i 's/(defined\((@TEMPLATE_FILE)\))/\1/' $ROOT/$PKG_BUILD/js/src/config/milestone.pl

  sed -i -e "s|\${includedir}|$SYSROOT_PREFIX/usr/include|" $ROOT/$PKG_BUILD/js/src/js.pc.in

  sed -i -e "s|./host_jskwgen|host_jskwgen|g" \
         -e "s|./host_jsoplengen|host_jsoplengen|g" \
         $ROOT/$PKG_BUILD/js/src/Makefile.in
}
