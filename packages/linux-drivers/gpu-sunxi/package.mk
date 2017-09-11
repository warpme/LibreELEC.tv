################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
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

PKG_NAME="gpu-sunxi"
PKG_VERSION="d06b414"
PKG_SHA256="6a1bc65d4876abc2d66ee1fd870ff31fb66a2546642b042a68192ebb42929d08"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Icenowy/sunxi-mali"
PKG_URL="https://github.com/Icenowy/sunxi-mali/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="sunxi-mali-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="gpu-sunxi: Linux drivers for Mali GPUs found in Allwinner SoCs"
PKG_LONGDESC="gpu-sunxi: Linux drivers for Mali GPUs found in Allwinner SoCs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

RELEASE=r7p0
DRIVER_DIR=$PKG_BUILD/$RELEASE/src/devicedrv/mali/

post_patch() {
  pushd $PKG_BUILD/$RELEASE
    for patch in $PKG_BUILD/patches/*.patch; do
      patch -p1 < $patch
    done
  popd
}

make_target() {
  USING_UMP=0 \
  BUILD=$BUILD \
  USING_PROFILING=0 \
  MALI_PLATFORM=sunxi \
  USING_DVFS=1 \
  USING_DEVFREQ=0 \
  KDIR=$(kernel_path) \
  CROSS_COMPILE=$TARGET_PREFIX \
    make -C $DRIVER_DIR
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
    cp $DRIVER_DIR/*.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
}
