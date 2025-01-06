# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="bcmdhd"
PKG_VERSION="01f5a449f2a34e7766d0741060a954ec6fa422a3"
PKG_SHA256="68b11462b7a3acd50efc608a85404fe91c345b3e4b979f9625d0156cff28f78b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/StreamUnlimited/broadcom-bcmdhd-4359"
PKG_URL="https://github.com/ihipop/broadcom-bcmdhd-4359/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="GPL Broadcom driver for bcm4359 / AP6398S"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make -C $(kernel_path) V=1 prepare && \
  kernel_make -C $(kernel_path) V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       M=$(pwd) \
       modules \
       CONFIG_BCMDHD_NVRAM_PATH="/lib/firmware/bcmdhd/" \
       CONFIG_BCMDHD_FW_PATH="/lib/firmware/bcmdhd/" \
       CONFIG_BCMDHD_SDIO=y \
       CONFIG_BCMDHD_SDIO_IRQ=y \

}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
  FW_TARGET_DIR=${INSTALL}/$(get_full_firmware_dir)
  mkdir -p ${FW_TARGET_DIR}
    cp -Lrv ${PKG_BUILD}/firmware  ${FW_TARGET_DIR}/bcmdhd
}
