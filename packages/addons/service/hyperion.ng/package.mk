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

PKG_NAME="hyperion.ng"
PKG_VERSION="4faa505"
PKG_REV="100"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/hyperion-project/hyperion.ng"
PKG_URL="https://github.com/hyperion-project/hyperion.ng/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python libusb qtbase qtserialport avahi protobuf rpi_ws281x"
PKG_SECTION="service"
PKG_SHORTDESC="Hyperion.ng: The reworked version (next generation) of Hyperion"
PKG_LONGDESC="Hyperion.ng($PKG_VERSION) The reworked version (next generation) of Hyperion"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Hyperion (next generation)"
PKG_ADDON_TYPE="xbmc.service"

case $PROJECT in
  RPi)
    HYPERION_PLATFORM="-DPLATFORM=rpi"
    ;;
  RPi2)
    HYPERION_PLATFORM="-DPLATFORM=rpi-pwm"
    ;;
  WeTek_Play|WeTek_Core)
    HYPERION_PLATFORM="-DPLATFORM=amlogic"
    ;;
  WeTek_Play_2|WeTek_Hub|Odroid_C2)
    HYPERION_PLATFORM="-DPLATFORM=amlogic64"
    ;;
  Generic)
    HYPERION_PLATFORM="-DPLATFORM=x86"
    ;;
  imx6)
    HYPERION_PLATFORM="-DPLATFORM=imx6"
    ;;
esac

PKG_CMAKE_OPTS_TARGET="-DUSE_SYSTEM_PROTO_LIBS=ON \
                       -DUSE_SHARED_AVAHI_LIBS=ON \
                       $HYPERION_PLATFORM \
                       -Wno-dev"

pre_build_target() {
  cp -a $(get_build_dir rpi_ws281x)/* $ROOT/$PKG_BUILD/dependencies/external/rpi_ws281x
}

pre_configure_target() {
  echo "" > ../cmake/FindGitVersion.cmake
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp $PKG_BUILD/.$TARGET_NAME/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
    cp -P $PKG_BUILD/config/hyperion.config.json.default $ADDON_BUILD/$PKG_ADDON_ID/config

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/effects
    cp -PR $PKG_BUILD/effects/* $ADDON_BUILD/$PKG_ADDON_ID/effects

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
