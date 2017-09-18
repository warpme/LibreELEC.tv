PKG_NAME="pydbus"
PKG_VERSION="0.6.0"
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://freedesktop.org/wiki/Software/dbus"
PKG_URL="https://github.com/LEW21/$PKG_NAME/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python setuptools:host pygobject"
PKG_SECTION="python/system"
PKG_SHORTDESC="Pythonic DBus library"
PKG_LONGDESC="Pythonic DBus library"

make_target() {
  :
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}
