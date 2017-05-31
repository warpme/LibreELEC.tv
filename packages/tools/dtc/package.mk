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

PKG_NAME="dtc"
PKG_VERSION="fe50bd1"
PKG_SHA256="d8dd1a0893bd2ea3f3aea2c78eb6ffc0062ab23bc1303eb29f96e4f0c2f38453"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://git.kernel.org/pub/scm/utils/dtc/dtc.git/"
PKG_URL="https://git.kernel.org/pub/scm/utils/dtc/dtc.git/snapshot/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_VERSION"
PKG_DEPENDS_HOST="Python:host swig:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="The Device Tree Compiler"
PKG_LONGDESC="The Device Tree Compiler"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="dtc"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_BUILD/dtc $INSTALL/usr/bin
}

PKG_MAKE_OPTS_HOST="dtc libfdt"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp -P $PKG_BUILD/dtc $TOOLCHAIN/bin
    cp -P $PKG_BUILD/libfdt/libfdt.so $TOOLCHAIN/lib
}

post_makeinstall_host() {
  python ./pylibfdt/setup.py build_ext --inplace
  python ./pylibfdt/setup.py install --prefix=$TOOLCHAIN

  touch $TOOLCHAIN/lib/python2.7/site-packages/pylibfdt/__init__.py
}
