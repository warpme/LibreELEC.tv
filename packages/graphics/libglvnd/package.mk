
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libglvnd"
PKG_VERSION="55fad54"
#PKG_SHA256="e9e48fdb4de139dc4d9880aa1473158a16ff6aff63d14341367bd30a51ff39fa"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://github.com/NVIDIA/libglvnd/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="graphics"
PKG_SHORTDESC="The GL Vendor-Neutral Dispatch library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-egl \
                           --disable-glx \
                           --disable-gles \
                           --disable-tls \
                           --enable-asm"
