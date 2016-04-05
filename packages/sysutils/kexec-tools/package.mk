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

PKG_NAME="kexec-tools"
PKG_VERSION="2.0.13"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://git.kernel.org/cgit/utils/kernel/kexec/kexec-tools.git"
PKG_URL="https://www.kernel.org/pub/linux/utils/kernel/kexec/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_INIT="toolchain zlib:init"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="Load another kernel from the currently executing Linux kernel"
PKG_LONGDESC="Load another kernel from the currently executing Linux kernel"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

INIT_CONFIGURE_OPTS="ac_cv_lib_xenctrl_xc_kexec_load=no \
                     --without-xen \
                     --with-zlib \
                     --prefix=/"

pre_configure_init() {
# fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME
}

post_makeinstall_init() {
  rm -rf $INSTALL/lib
}
