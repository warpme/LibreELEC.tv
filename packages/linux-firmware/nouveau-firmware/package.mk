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

PKG_NAME="nouveau-firmware"
PKG_VERSION="325.15"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="other"
PKG_SITE=""
PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86/$PKG_VERSION/NVIDIA-Linux-x86-$PKG_VERSION.run"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="nouveau-firmware"
PKG_LONGDESC="nouveau-firmware"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  [ -d $PKG_BUILD ] && rm -rf $PKG_BUILD
  mkdir -p $ROOT/$PKG_BUILD && cp $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME $ROOT/$PKG_BUILD/

  wget -P $ROOT/$PKG_BUILD/ https://raw.githubusercontent.com/imirkin/re-vp2/master/extract_firmware.py
}

make_target() {
  sh $PKG_SOURCE_NAME --extract-only

  python extract_firmware.py
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/firmware/nouveau
    cp -a nv* vuc-* $INSTALL/lib/firmware/nouveau
}
