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

PKG_NAME="libglvnd"
PKG_VERSION="e202ebf"
PKG_SHA256="790e8cf0a7a81ccd42c8267dcc4be95fc03f28efc4bcd629af826ece3c7567d3"
PKG_ARCH="any"
PKG_LICENSE="custom"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://github.com/NVIDIA/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="graphics"
PKG_SHORTDESC="The GL Vendor-Neutral Dispatch library"
PKG_LONGDESC="The GL Vendor-Neutral Dispatch library"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-egl"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-glx"
else
  exit 0
fi

if [ "$OPENGLES" = "mesa" ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-gles"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-gles"
fi
