# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="ipset"
PKG_VERSION="7.23"
PKG_LICENSE="GPL"
PKG_SITE="http://ipset.netfilter.org"
PKG_URL="http://ipset.netfilter.org/ipset-${PKG_VERSION}.tar.bz2"
PKG_SHA256="db3a51a9ebf27c7cbd0a1482c46c5e0ed630c28c796f73287c4b339dd46086e5"
PKG_DEPENDS_TARGET="toolchain linux libmnl"
PKG_TOOLCHAIN="autotools"
PKG_SECTION=""
PKG_SHORTDESC="Ipset binary"
PKG_LONGDESC="IP sets are a framework inside the Linux kernel, which can be administered by the ipset utility."

PKG_CONFIGURE_OPTS_TARGET="--with-kbuild=$(kernel_path) CPPFLAGS=-I${SYSROOT_PREFIX}/usr/include"
