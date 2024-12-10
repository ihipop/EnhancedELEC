# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="nftables"
PKG_VERSION="1.1.1"
PKG_SHA256="6358830f3a64f31e39b0ad421d7dadcd240b72343ded48d8ef13b8faf204865a"
PKG_LICENSE="GPL"
PKG_SITE="http://netfilter.org/projects/nftables"
PKG_URL="http://netfilter.org/projects/${PKG_NAME}/files/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libnftnl libedit gmp"
PKG_LONGDESC="nftables is the modern Linux kernel packet classification framework"