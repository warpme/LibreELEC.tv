################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="pygobject"
PKG_VERSION="3.26.0"
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/GNOME/pygobject"
PKG_URL="https://github.com/GNOME/pygobject/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python libffi gobject-introspection"
PKG_SECTION="python/devel"
PKG_SHORTDESC="This archive contains bindings for the GLib, and GObject, to be used in Python."
PKG_LONGDESC="This archive contains bindings for the GLib, and GObject, to be used in Python."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-cairo \
                           --with-python=$TOOLCHAIN/bin/python2.7"

pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python2-config --includes)"
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/pygobject
}
