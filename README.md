# About

This is an Enhanced Edition of LibreELEC.tv, which makes the device can act as both a media box and a router/server.

Currently it's only tested on ROCKCHIP NANOPC T4

# Build

```bash
docker build --pull -t libreelec  tools/docker/bookworm
docker run \
  -it --rm \
  --log-driver none \
  -e DISTRO="EnhancedELEC" \
  -e ADDON_OVERWRITE="yes" \
  -v $(pwd):/build \
  -v ~/.libreelec/:/build/.libreelec \
  -w /build libreelec bash
# RUN the real build
export PROJECT=Rockchip ARCH=aarch64 DEVICE=RK3399 CUSTOM_VERSION=999 UBOOT_SYSTEM=nanopc-t4
make image
```

To bundle pre-installed addons (e.g. Docker, Chinese language pack) into the image, build addons first then use `OEM=yes`:

```bash
scripts/create_addon docker
OEM=yes ...... make image
```

# Features enabled

## KERNEL
  [Here](./distributions/EnhancedELEC/kernel_options#L178)

## PACKAGE
  - ipset
  - nftables
  - bubblewrap
  - docker (Kodi addon, a relatively latest version)
  - systemd-nspawn / machinectl (with persistent `/storage/.systemd-machines` storage)
  - systemd-coredump / coredumpctl (with Zstd compression, persistent `/storage/.cache/coredump` storage)
  - agetty
  - entware (install via `installentware`, ported from CoreELEC)

## SYSTEM
  - serial-getty on UART with auto login (could be disabled by `systemctl mask serial-getty@ttyS2`)
  - a series of systemd VT/console/tty pre-defined services
  - coredump configuration overlay at `/storage/.config/coredump.conf.d/` (user-overridable)
  - systemd-nspawn configuration overlay at `/storage/.config/systemd-nspawn/` (user-overridable)

# The Original LibreELEC Readme
<details>
<summary><i><b>
View
</b></i></summary>

# LibreELEC

LibreELEC is a 'Just enough OS' Linux distribution for the award-winning [Kodi](https://kodi.tv) software on popular mediacentre hardware. Further information on the project can be found on the [LibreELEC website](https://libreelec.tv).

**Issues & Support**

Please ask questions in the [LibreELEC forum: Help & Support](https://forum.libreelec.tv/forum-3.html) or ask a member of project staff in the #libreelec IRC channel on Libera.Chat. Please report bugs via [GitHub Issues](https://github.com/LibreELEC/LibreELEC.tv/issues).

**Donations**

Contributions towards current project funding goals can be made via [OpenCollective](https://opencollective.com/libreelec/donate).

**License**

LibreELEC original code is released under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html).

**Copyright**

As LibreELEC includes code from many upstream projects it has many copyright owners; notably [OpenELEC](https://openelec.tv) which we forked from after disagreeing with project direction and management, and [OpenBricks/GeeXboX](https://github.com/OpenBricks/openbricks/blob/master/AUTHORS) the uncredited source of the original 2009 build system. LibreELEC makes no claim of copyright on any upstream code. However all original LibreELEC authored code is copyright LibreELEC.tv. Patches to upstream code have the same license as the upstream project unless specified otherwise. For a complete copyright list please checkout the source code to examine license headers. Unless expressly stated otherwise all code submitted to the LibreELEC project (in any form) is licensed under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html) and copyright is donated to the project. This approach gives the project freedom to maintain the code without the overhead of preserving contact with every submitter, e.g. GPLv3. You are free to retain copyright by adding your copyright header to each submitted code page. If you submit code that is not your own work it is your responsibility to place a header stating the copyright.

</details>