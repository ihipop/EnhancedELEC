#!/bin/bash
set -o pipefail
git config --global --add safe.directory /build
# Load global options if available
. distributions/EnhancedELEC/version
[ -f .libreelec/options ] && . .libreelec/options

# Device Specific Configuration
export PROJECT=Rockchip
export ARCH=aarch64
export DEVICE=RK3399
export UBOOT_SYSTEM=nanopc-t4
export BUILD_PERIODIC=daily
export DISTRO=EnhancedELEC

# Build System Configuration
export CCACHE_DIR=/build/.ccache


echo "Starting build..."

rm -f build.log

if [ "${OEM}" = "yes" ]; then
  echo "building addons..."
  rm -rf "target/addons/${OS_VERSION}/${DEVICE}/${ARCH}"
  if ! ./scripts/create_addon docker system-tools service.locale >> build.log 2>&1; then
    echo "===================================================="
    echo "!!! ADDONS BUILD FAILED !!!"
    echo "===================================================="
    tail -n 500 build.log
    exit 1
  fi
fi

# Run the build
echo "building image..."
if ! make image >> build.log  2>&1; then
  echo "===================================================="
  echo "!!! IMAGE BUILD FAILED !!!"
  echo "===================================================="
  tail -n 500 build.log
  exit 1
fi

# Print ccache stats after build
./scripts/ccache_stats
