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

PKG_NAME="plymouth"
PKG_VERSION="63148b2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://cgit.freedesktop.org/plymouth/"
PKG_URL="https://cgit.freedesktop.org/plymouth/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION*"
PKG_DEPENDS_INIT="toolchain gcc:init libpng"
PKG_DEPENDS_TARGET="toolchain libpng"
PKG_SECTION="tools"
PKG_SHORTDESC="A graphical boot splash screen with kernel mode-setting support"
PKG_LONGDESC="A graphical boot splash screen with kernel mode-setting support"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PLYMOUTH_DRM="--disable-drm"
if [ "$UVESAFB_SUPPORT" = yes ]; then
  PKG_DEPENDS_INIT="$PKG_DEPENDS_INIT v86d:init"

  PLYMOUTH_DRM="--enable-drm"
fi

PKG_CONFIGURE_OPTS_INIT="--disable-systemd-integration \
                         --disable-upstart-monitoring \
                         --disable-gdm-transition \
                         $PLYMOUTH_DRM \
                         --enable-tracing \
                         --disable-pango \
                         --disable-gtk \
                         --disable-documentation \
                         --with-logo=/usr/share/plymouth/logo.png \
                         --with-background-color=0x000000 \
                         --without-udev \
                         --without-rhgb-compat-link \
                         --without-system-root-install"

PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_INIT"

post_makeinstall_init() {
  rm -rf $INSTALL/usr/lib/systemd
  rm -rf $INSTALL/usr/lib/plymouth/plymouth-generate-initrd
  rm -rf $INSTALL/usr/lib/plymouth/plymouth-populate-initrd
  rm -rf $INSTALL/usr/lib/plymouth/plymouth-update-initrd
  rm -rf $INSTALL/usr/sbin/plymouth-set-default-theme

  mkdir -p $INSTALL/usr/share/plymouth
    cp $DISTRO_DIR/$DISTRO/le-header-logo.png $INSTALL/usr/share/plymouth/logo.png

  mkdir -p $INSTALL/etc/plymouth
    cp $PKG_DIR/config/plymouthd.conf $INSTALL/etc/plymouth
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/systemd
  rm -rf $INSTALL/usr/lib/plymouth/plymouth-generate-initrd
  rm -rf $INSTALL/usr/lib/plymouth/plymouth-populate-initrd
  rm -rf $INSTALL/usr/lib/plymouth/plymouth-update-initrd
  rm -rf $INSTALL/usr/sbin/plymouth-set-default-theme

  mkdir -p $INSTALL/usr/share/plymouth
    cp $DISTRO_DIR/$DISTRO/le-header-logo.png $INSTALL/usr/share/plymouth/logo.png

#  mkdir -p $INSTALL/etc/plymouth
#    cp $PKG_DIR/config/plymouthd.conf $INSTALL/etc/plymouth

  mkdir -p $INSTALL/etc/plymouth
    ln -sf /storage/.config/plymouthd.conf $INSTALL/etc/plymouth/plymouthd.conf
}

post_install() {
  enable_service plymouth-halt.service       halt.target
  enable_service plymouth-poweroff.service   poweroff.target
  enable_service plymouth-reboot.service     reboot.target
  enable_service plymouth-quit.service       multi-user.target
  enable_service plymouth-quit-wait.service  multi-user.target
  enable_service plymouth-read-write.service sysinit.target
  enable_service plymouth-start.service      sysinit.target
}
