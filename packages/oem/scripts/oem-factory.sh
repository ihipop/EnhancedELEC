#!/bin/sh
KODI_ROOT=$HOME/.kodi
OEM_INITIATED="${KODI_ROOT}/userdata/.oem_initiated"
if [ ! -f "${OEM_INITIATED}" ]; then
    mkdir -p "$(dirname "${OEM_INITIATED}")"
    FACTORY_DEFAULT=/usr/share/kodi/factory-default.tar.xz
    if [ -f "${FACTORY_DEFAULT}" ]; then
        mkdir -p "${KODI_ROOT}"
        # inflate a factory default
        tar xvf "${FACTORY_DEFAULT}" -C "${HOME}"
    fi
    # enable all service addon
    for SVC in "${KODI_ROOT}/addons/"*"/system.d/"*".service"; do
        SVC=$(basename "${SVC}")
        CLEAN_NAME="${SVC%.service}"
        service-addon-wrapper enable "${CLEAN_NAME}" "${KODI_ROOT}/addons/${CLEAN_NAME}"
    done
    touch "${OEM_INITIATED}"
fi