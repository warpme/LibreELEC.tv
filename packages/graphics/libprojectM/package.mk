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

PKG_NAME="libprojectM"
PKG_VERSION="e28bb99"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projectm.sourceforge.net/"
PKG_URL="https://github.com/projectM-visualizer/projectm/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="projectm-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain ftgl freetype $OPENGL"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libprojectM:"
PKG_LONGDESC="libprojectM:"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
                       -DINCLUDE-PROJECTM-QT=OFF \
                       -DINCLUDE-PROJECTM-PULSEAUDIO=OFF \
                       -DINCLUDE-PROJECTM-LIBVISUAL=OFF \
                       -DINCLUDE-PROJECTM-LIBVISUAL-ALSA=OFF \
                       -DINCLUDE-PROJECTM-JACK=OFF \
                       -DINCLUDE-PROJECTM-TEST=OFF \
                       -DINCLUDE-PROJECTM-XMMS=OFF \
                       -DINCLUDE-PROJECTM-SDL=OFF \
                       -DINCLUDE-NATIVE-SAMPLES=OFF \
                       -DINCLUDE-NATIVE-PRESETS=OFF \
                       -DUSE_DEVIL=OFF \
                       -DUSE_FBO=ON \
                       -DUSE_FTGL=ON \
                       -DUSE_GLES1=OFF \
                       -DUSE_THREADS=ON \
                       -DUSE_OPENMP=OFF \
                       -DUSE_CG=OFF \
                       -DBUILD_PROJECTM_STATIC=ON \
                       -DDISABLE_NATIVE_PRESETS=OFF \
                       -DDISABLE_MILKDROP_PRESETS=OFF"
