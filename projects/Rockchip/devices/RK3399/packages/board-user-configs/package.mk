PKG_NAME="board-user-configs"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SECTION="sysutils"
PKG_SHORTDESC="Board-specific user configurations for RK3399"
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_TARGET="systemd"

post_makeinstall_target() {
  if [ -d "${PKG_DIR}/config/${UBOOT_SYSTEM}" ]; then
    mkdir -p ${INSTALL}/usr/config/
    cp -PR "${PKG_DIR}/config/${UBOOT_SYSTEM}"/. ${INSTALL}/usr/config/
    # Symlink tmpfiles.d files to system-level directory to ensure they run on first boot
    if [ -d "${PKG_DIR}/config/${UBOOT_SYSTEM}/tmpfiles.d" ]; then
      mkdir -p "${INSTALL}/usr/lib/tmpfiles.d"
      for conf in "${PKG_DIR}/config/${UBOOT_SYSTEM}/tmpfiles.d/"*; do
        [ -e "$conf" ] || continue
        ln -sf "/usr/config/tmpfiles.d/$(basename "$conf")" "${INSTALL}/usr/lib/tmpfiles.d/$(basename "$conf")"
      done
    fi
  fi
}
