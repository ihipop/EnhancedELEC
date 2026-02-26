# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="oem"
PKG_VERSION="20260225"
PKG_REV="1"
PKG_LICENSE="various"
PKG_SITE="http://www.libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi"
# PKG_SECTION="virtual"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"
PKG_TOOLCHAIN="manual"


make_target() {
	KODI_RELEASE=$(get_pkg_version kodi)
	KODI_RELEASE=$(echo "${KODI_RELEASE##*-}" | tr '[:upper:]' '[:lower:]')

	FILE_SYSTEM="${PKG_BUILD}/factory-default/"
	# collect project factory defaut files
	(
		cd ${PKG_DIR}/filesystem/
		cp -av . "${FILE_SYSTEM}"
	)

	# addons
	FACTORY_ADDONS="${FILE_SYSTEM}/.kodi/addons"
	mkdir -p "${FACTORY_ADDONS}"
	ADDON_TARGET_DIR="${TARGET_IMG}/${ADDONS}/${ADDON_VERSION}/${DEVICE:-${PROJECT}}/${TARGET_ARCH}"
	(
		ADDON_REPO_XML="https://mirrors.kodi.tv/addons/${KODI_RELEASE}/addons.xml"
		wget "${ADDON_REPO_XML}" -O -|grep -oP '<path>\K.*?\.zip(?=</path>)' > addons.txt
		ADDON_LISTS=("resource.language.zh_cn")
		for ITEM in "${ADDON_LISTS[@]}"; do
			DL_DIR="${ADDON_TARGET_DIR}/${ITEM}"
			mkdir -p "${DL_DIR}"
			HTTP_PATH=$(grep ${ITEM} addons.txt | head -n 1)
			if [ -z ${HTTP_PATH} ]; then
				echo "Can't find the addon: ${ITEM}"
				exit 255
			fi
			wget "https://mirrors.kodi.tv/addons/${KODI_RELEASE}/${HTTP_PATH}" -O "${DL_DIR}/${ITEM}.zip"
		done
	)
	ADDON_MANIFEST="addon-manifest.txt"
	echo -n > ${ADDON_MANIFEST}
	for ZIP in "${ADDON_TARGET_DIR}"/*/*.zip ; do
		CLEAN_NAME=$(echo -n "${ZIP}" | sed -E 's/(-[0-9.]+)?\.zip$//')
		rm -rf "${FACTORY_ADDONS}/${CLEAN_NAME}"*
		unzip  -o "${ZIP}" -d "${FACTORY_ADDONS}"
		# remember the addon
		echo "$(basename ${CLEAN_NAME})" >>${ADDON_MANIFEST}
	done
}

makeinstall_target() {
	mkdir -p ${INSTALL}/usr/share/kodi/
	rm -f ${PKG_BUILD}/factory-default.tar.xz
	tar cJvf ${PKG_BUILD}/factory-default.tar.xz --owner=root --group=root -C ./factory-default .
	cp -av ${PKG_BUILD}/factory-default.tar.xz ${INSTALL}/usr/share/kodi/
	mkdir -p $INSTALL/usr/lib/libreelec
  	cp -PR $PKG_DIR/scripts/* $INSTALL/usr/lib/libreelec
 }

post_install() {
	enable_service oem-factory.service
	# enable the addons
	while read -r LINE; do
		xmlstarlet ed -L \
				--subnode "/addons" -t elem -n "addon" -v "${LINE}" \
				--subnode "/addons/addon[last()]" -t attr -n "optional" -v "true" \
				"${INSTALL}/usr/share/kodi/system/addon-manifest.xml"
	done < "${PKG_BUILD}/addon-manifest.txt"
}