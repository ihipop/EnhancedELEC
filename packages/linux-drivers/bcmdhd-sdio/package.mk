# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="bcmdhd-sdio"
PKG_VERSION="615859b212fe199aa44254fe1561ae40ecd7771e"
PKG_SHA256="26ed8eadca981bda9645b70e3eeb613ab1025191ded23c846bd17a616bf85173"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/ihipop/broadcom-bcmdhd"
PKG_URL="https://github.com/ihipop/broadcom-bcmdhd/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Broadcom bcmdhd-sdio driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  #kernel_make -C $(kernel_path) V=1 prepare &&
  kernel_make -C $(kernel_path) V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       M=${PKG_BUILD} \
       modules \
       CONFIG_BCMDHD=m \
       CONFIG_BCMDHD_NVRAM_PATH="/lib/firmware/bcmdhd/" \
       CONFIG_BCMDHD_FW_PATH="/lib/firmware/bcmdhd/" \
       CONFIG_BCMDHD_SDIO=y \
       CONFIG_BCMDHD_OOB= 
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
  FW_TARGET_DIR=${INSTALL}/$(get_full_firmware_dir)
  mkdir -p ${FW_TARGET_DIR}
    cp -Lrv ${PKG_BUILD}/firmware  ${FW_TARGET_DIR}/bcmdhd
}
