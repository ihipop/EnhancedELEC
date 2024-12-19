# About

This is an Enhanced Edition of LibreELEC.tv, which makes the device can act as both a media box and a router/server.

Currently it's only tested on ROCKCHIP NANOPC T4

# Build

```bash
docker build --pull -t libreelec.buster  tools/docker/buster
docker run \
  -it --rm \
  --log-driver none \
  -e DISTRO="EnhancedELEC" \
  -e ADDON_OVERWRITE="yes" \
  -v `pwd`:/build \
  -v ~/.libreelec/:/build/.libreelec \
  -w /build libreelec.buster bash
# RUN the real build
PROJECT=Rockchip ARCH=arm DEVICE=RK3399 CUSTOM_VERSION=10.0.2 UBOOT_SYSTEM=nanopc-t4 make image
```

# Features enabled

## KERNEL
  ### currently RK3399 only:
  - enable builtin PCIE device so we can mount NVME disk during early kernel boot and put storage on nvme disk
  - add more iptables/iproute features eg: 
    - CONFIG_IP_ADVANCED_ROUTER
    - CONFIG_NET_IPGRE
    - CONFIG_DEFAULT_BBR
    - CONFIG_NF_TABLES
    - CONFIG_IP_SET
    - CONFIG_NF_TPROXY_IPV4/IPV6
    - CONFIG_VLAN_8021Q
    - CONFIG_FIB_RULES
    - CONFIG_NETFILTER_XT_MARK
    - NF_CONNTRACKNF_CONNTRACK
    - CONFIG_THERMAL_WRITABLE_TRIPS (kernel < 6.9)
    - ......


## PACKAGE
  - ipset
  - nftables
  - bubblewrap
  - docker (a relatively latest version)
  - systemd-nspawn
  - agetty
  - ......

## SYSTEM
  - serial-getty on UART with auto login (could be disabled by `systemctl mask serial-getty@ttyS2`)
  - a serious of systemd VT/console/tty pre-defined service
  - support entware mount point (/opt)
  - add fake intereptor for arm64 kernel on arm64 device while the rootfs is arm (entware is suggested )

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

Contributions towards current project funding goals can be sent via PayPal to donations@libreelec.tv

**License**

LibreELEC original code is released under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html).

**Copyright**

As LibreELEC includes code from many upstream projects it has many copyright owners; notably [OpenELEC](https://openelec.tv) which we forked from after disagreeing with project direction and management, and [OpenBricks/GeeXboX](https://github.com/OpenBricks/openbricks/blob/master/AUTHORS) the uncredited source of the original 2009 build system. LibreELEC makes no claim of copyright on any upstream code. However all original LibreELEC authored code is copyright LibreELEC.tv. Patches to upstream code have the same license as the upstream project unless specified otherwise. For a complete copyright list please checkout the source code to examine license headers. Unless expressly stated otherwise all code submitted to the LibreELEC project (in any form) is licensed under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html) and copyright is donated to the project. This approach gives the project freedom to maintain the code without the overhead of preserving contact with every submitter, e.g. GPLv3. You are free to retain copyright by adding your copyright header to each submitted code page. If you submit code that is not your own work it is your responsibility to place a header stating the copyright.

</details>
