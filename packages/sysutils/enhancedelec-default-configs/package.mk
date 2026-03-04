# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024-present ihipop (ihipop@gmail.com)

PKG_NAME="enhancedelec-default-configs"
PKG_VERSION="1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/ihipop/EnhancedELEC"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_SECTION="sysutils"
PKG_SHORTDESC="Enhanced common user configurations for the system"
PKG_LONGDESC="This package provides enhanced default configurations for various system tools like Vim and shell environments, deployed via the /usr/config overlay mechanism."
PKG_TOOLCHAIN="manual"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config
  cp -PR ${PKG_DIR}/config/* ${INSTALL}/usr/config/
}
