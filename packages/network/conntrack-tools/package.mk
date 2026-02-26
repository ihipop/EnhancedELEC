PKG_NAME="conntrack-tools"
PKG_VERSION="1.4.8"
PKG_SHA256="067677f4c5f6564819e78ed3a9d4a8980935ea9273f3abb22a420ea30ab5ded6"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://www.netfilter.org/projects/conntrack-tools/"
PKG_URL="https://www.netfilter.org/projects/conntrack-tools/files/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libnfnetlink libmnl libnetfilter_conntrack libnetfilter_cttimeout libnetfilter_cthelper libnetfilter_queue"
PKG_SECTION="network"
PKG_SHORTDESC="Connection tracking userspace tools"
PKG_LONGDESC="The conntrack-tools are a set of tools targeted at system administrators. They are conntrack, the userspace command line interface, and conntrackd, the connection tracking daemon."

post_makeinstall_target() {
  # manually remove conntrackd binary to save space
  safe_remove "${INSTALL}/usr/sbin/conntrackd"
}
