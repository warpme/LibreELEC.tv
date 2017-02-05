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

PKG_NAME="jemalloc"
PKG_VERSION="4.4.0"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://jemalloc.net"
PKG_URL="https://github.com/jemalloc/jemalloc/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC=""
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd $ROOT/$PKG_BUILD/.$TARGET_NAME
  make build_lib_static
}

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX install_lib_static install_include
}
