# Maintainer: Vladislav Nepogodin <nepogodin.vlad@gmail.com>

pkgname=pakos-hello-git
pkgver=15.2f636e4
pkgrel=1
pkgdesc='Welcome screen for pakos'
arch=('x86_64' 'x86_64_v3')
license=(GPLv3)
url="https://github.com/aamirali51/pakos-welcome"
depends=('gtk3' 'glib2')
makedepends=('meson' 'git' 'mold' 'rustup' 'clang')
source=("${pkgname}::git+$url.git")
sha512sums=('SKIP')
provides=('pakos-hello')
conflicts=('pakos-hello')
options=(strip)

pkgver() {
  cd "${srcdir}/${pkgname}"
  printf "%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

check() {
  cd ${srcdir}/$pkgname
  cargo test --release --verbose

  echo "--Checking with clippy--"
  cargo clippy --release

  echo "--Checking style--"
  cargo fmt --all -- --check
}

build() {
  cd "${srcdir}/${pkgname}"

  if ! rustc --version | grep nightly >/dev/null 2>&1; then
    echo "Installing nightly compiler…"
    rustup toolchain install nightly
    rustup default nightly
  fi

  if ! which cargo >/dev/null 2>&1 || ! cargo fmt --help >/dev/null 2>&1; then
    echo "Installing rustfmt…"
    rustup component add rustfmt
  fi

  if ! which cargo >/dev/null 2>&1 || ! cargo clippy --help >/dev/null 2>&1; then
    echo "Installing clippy…"
    rustup component add clippy
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

  install -Dvm644 ../${pkgname/-git}.desktop \
    "$pkgdir/etc/skel/.config/autostart/${pkgname/-git}.desktop"
}

# vim:set sw=2 sts=2 et:
