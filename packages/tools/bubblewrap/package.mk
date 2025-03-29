# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="bubblewrap"
PKG_VERSION="0.11.0"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/containers/bubblewrap"
PKG_URL="https://github.com/containers/bubblewrap/releases/download/v${PKG_VERSION}/bubblewrap-${PKG_VERSION}.tar.xz"
PKG_SHA256="988fd6b232dafa04b8b8198723efeaccdb3c6aa9c1c7936219d5791a8b7a8646"
PKG_DEPENDS_TARGET="toolchain"
# PKG_TOOLCHAIN="autotools"
PKG_SECTION=""
PKG_SHORTDESC="Unprivileged sandboxing tool"
PKG_LONGDESC="Many container runtime tools like systemd-nspawn, docker, etc. focus on providing infrastructure for system administrators and orchestration tools (e.g. Kubernetes) to run containers."

PKG_MESON_OPTS_TARGET="-Dman=disabled"

pre_configure_target() {
	CFLAGS="-O2 -Wp,-D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined"
}