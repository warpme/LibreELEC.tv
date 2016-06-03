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

PKG_NAME="krb5"
PKG_VERSION="1.13.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://web.mit.edu/kerberos/"
PKG_URL="http://web.mit.edu/kerberos/dist/$PKG_NAME/${PKG_VERSION%.*}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="The Kerberos network authentication system"
PKG_LONGDESC="The Kerberos network authentication system"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_SCRIPT="src/configure"

PKG_CONFIGURE_OPTS_TARGET="krb5_cv_attr_constructor_destructor=yes \
                           krb5_cv_cc_flag__dash_Werror_dash_implicit_dash_function_dash_declaration=no \
                           krb5_cv_cc_flag__dash_Werror_eq_uninitialized=no \
                           ac_cv_func_regcomp=no \
                           ac_cv_printf_positional=no \
                           --enable-static \
                           --disable-shared \
                           --enable-delayed-initialization \
                           --with-crypto-impl=openssl \
                           --without-tcl \
                           --without-ldap \
                           --without-system-verto"

pre_configure_target() {
  export LIBS="-lm"
}

post_makeinstall_target() {
  cp $SYSROOT_PREFIX/usr/bin/krb5-config $ROOT/$TOOLCHAIN/bin/krb5-config
}
