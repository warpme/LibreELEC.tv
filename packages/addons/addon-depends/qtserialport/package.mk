################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
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

PKG_NAME="qtserialport"
PKG_VERSION="5.7.0"
PKG_ARCH="any"
PKG_LICENCE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt.io/official_releases/qt/5.7/$PKG_VERSION/submodules/$PKG_NAME-opensource-src-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain qtbase"
PKG_SOURCE_DIR="$PKG_NAME-opensource-src-$PKG_VERSION"
PKG_SHORTDESC="Provides access to hardware and virtual serial ports"
PKG_LONGDESC="Provides access to hardware and virtual serial ports"
PKG_AUTORECONF="no"

configure_target() {
  mkdir -p $ROOT/$PKG_BUILD/.$TARGET_NAME
    cd $ROOT/$PKG_BUILD/.$TARGET_NAME

  qmake ..
}
