################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018 Team LibreELEC
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

PKG_NAME="ampak-firmware"
PKG_VERSION="98962b9"
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/chewitt/ampak-firmware"
PKG_URL="https://github.com/chewitt/ampak-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_TOOLCHAIN="manual"
PKG_SHORTDESC="firmware-wetek: firmware for the Broadcom SDIO chips used in Ampak modules"

makeinstall_target() {
  make all
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -av brcm_patchram_plus $INSTALL/usr/bin

  mkdir -p $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
    case "$SDIO_FIRMWARE" in
      WeTek_Hub)
        # ap6335
        cp -av ap6335/brcmfmac4339-sdio.bin $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        cp -av ap6335/brcmfmac4339-sdio.txt $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        cp -av ap6335/bcm4339.hcd $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        # ap6255
        cp -av ap6255/brcmfmac43455-sdio.bin $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        cp -av ap6255/brcmfmac43455-sdio.txt $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        cp -av ap6255/bcm4335c0.hcd $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        ;;
      WeTek_Play_2)
        # ap6330
        cp -av ap6330/brcmfmac4330-sdio.bin $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        cp -av ap6330/brcmfmac4330-sdio.txt $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        cp -av ap6330/bcm4330.hcd $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        ;;
      S905|S912)
        cp -av */* $INSTALL/$(get_kernel_overlay_dir)/lib/firmware/brcm
        ;;
    esac
}
