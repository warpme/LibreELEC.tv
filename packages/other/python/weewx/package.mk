################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="weewx"
PKG_VERSION="3.1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.weewx.com/"
PKG_URL="http://sourceforge.net/projects/weewx/files/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host Cheetah configobj:host configobj:target six:host six:target pyusb pyserial ephem Pillow"
PKG_PRIORITY="optional"
PKG_SECTION="python"
PKG_SHORTDESC="weewx is a free, open source, software program, written in Python, which interacts with your weather station to produce graphs, reports, and HTML pages."
PKG_LONGDESC="weewx is a free, open source, software program, written in Python, which interacts with your weather station to produce graphs, reports, and HTML pages."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  python setup.py build --quiet
}

makeinstall_target() {
  python setup.py install --quiet --root=$INSTALL
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/weewx
    cp $PKG_DIR/scripts/weewx-config $INSTALL/usr/lib/weewx

  mkdir -p $INSTALL/usr/bin/
    ln -s /usr/share/weewx/bin/weewxd $INSTALL/usr/bin/weewxd

  mkdir -p $INSTALL/usr/share/weewx/
    cp $PKG_DIR/config/weewx.conf $INSTALL/usr/share/weewx/

  mkdir -p $INSTALL/usr/share/weewx/bin/weewx/drivers
    cp $PKG_DIR/drivers/* $INSTALL/usr/share/weewx/bin/weewx/drivers/

  rm -r $INSTALL/usr/share/weewx/util
  rm -r $INSTALL/usr/share/weewx/docs
}

post_install() {
  enable_service weewx.service
}
