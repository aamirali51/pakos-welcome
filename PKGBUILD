# Maintainer: Vladislav Nepogodin <nepogodin.vlad@gmail.com>

pkgname=pakos-welcome
pkgver=1.0.9
pkgrel=8
pkgdesc='Welcome screen for pakosLinux'
arch=('x86_64')
license=(GPLv3)
url="https://github.com/aamirali51/pakos-welcome"
depends=('gtk3' 'glib2')
makedepends=('meson' 'git' 'mold' 'rustup' 'clang')
source=("${pkgname}::git+$url.git")
sha512sums=('SKIP')
provides=('pakos-welcome')
conflicts=('pakos-welcome')
replaces=('pakos-welcome-tool' 'pakos-welcome-tool-dev')
options=(strip)

build() {
  cd "${srcdir}/${pkgname}"

  if ! rustc --version | grep nightly >/dev/null 2>&1; then
    echo "Installing nightly compiler…"
    rustup toolchain install nightly
    rustup default nightly
  fi

  _cpuCount=$(grep -c -w ^processor /proc/cpuinfo)

  export RUSTFLAGS="-Cembed-bitcode -C opt-level=3 -Ccodegen-units=1 -Clinker=clang -C link-arg=-flto -Clink-arg=-fuse-ld=/usr/bin/mold"
  meson --buildtype=release --prefix=/usr build

  meson compile -C build --jobs $_cpuCount
}

package() {
  cd "${srcdir}/${pkgname}"/build

  export RUSTFLAGS="-Cembed-bitcode -C opt-level=3 -Ccodegen-units=1 -Clinker=clang -C link-arg=-flto -Clink-arg=-fuse-ld=/usr/bin/mold"
  DESTDIR="${pkgdir}" meson install

  cp "$pkgdir/usr/share/applications/$pkgname.desktop" "$pkgdir/usr/share/applications/system-tool.desktop"

  install -Dvm644 ../$pkgname.desktop \
    "$pkgdir/etc/skel/.config/autostart/$pkgname.desktop"
}

# vim:set sw=2 sts=2 et:
