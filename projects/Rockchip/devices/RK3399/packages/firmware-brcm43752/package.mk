PKG_NAME="firmware-brcm43752"
PKG_VERSION="master"
PKG_LICENSE="custom"
PKG_SITE="custom"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain brcmfmac_sdio-firmware"
PKG_LONGDESC="Broadcom 43752 custom firmware overrides"
PKG_TOOLCHAIN="manual"

make_target() {
  : # No building needed
}

makeinstall_target() {
  FW_TARGET_DIR=${INSTALL}/$(get_full_firmware_dir)
  mkdir -p ${FW_TARGET_DIR}/brcm
  cp -r ${PKG_DIR}/firmware/brcm/* ${FW_TARGET_DIR}/brcm/
}
