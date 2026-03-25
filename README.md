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
export PROJECT=Rockchip ARCH=aarch64 DEVICE=RK3399 UBOOT_SYSTEM=nanopc-t4 CUSTOM_VERSION=999 
make image
```

To bundle pre-installed addons (e.g. Docker, Chinese language pack) into the image, build addons first then use `OEM=yes`:

```bash
scripts/create_addon docker
OEM=yes make image
```

# Features enabled

## KERNEL
  [Here](./distributions/EnhancedELEC/kernel_options#L178)

## PACKAGE
  - network stack tools like: nftables ipset conntrack etc...
  - bubblewrap
  - docker (Kodi addon, a relatively latest version)
  - systemd-nspawn / machinectl (with persistent `/data/systemd-machines` link at storage `/storage/.data`)
  - systemd-coredump / coredumpctl (with Zstd compression, persistent `/storage/.cache/coredump` storage)
  - agetty
  - entware (install via `installentware`, ported from CoreELEC, could be disabled by `ENTWARE_SUPPORT=no`)
  - fstrim.service (disabled by default, enable via `systemctl enable fstrim.timer`)
  - ...

## SYSTEM
  - serial-getty on UART with auto login (could be disabled by `systemctl mask serial-getty@ttyS2`)
  - a series of systemd VT/console/tty pre-defined services
  - coredump configuration overlay at `/storage/.config/coredump.conf.d/` (user-overridable)
  - systemd-nspawn configuration overlay at `/storage/.config/systemd-nspawn/` (user-overridable)
  - ...

# The Original LibreELEC Readme
<details>
<summary><i><b>
View
</b></i></summary>

[LibreELEC.md](https://github.com/LibreELEC/LibreELEC.tv/blob/master/README.md)

</details>