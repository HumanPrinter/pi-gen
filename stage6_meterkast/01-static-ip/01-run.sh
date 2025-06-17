#!/bin/bash -e

echo '8021q' >> ${ROOTFS_DIR}/etc/modules

mkdir -p ${ROOTFS_DIR}/etc/netplan/

cat > ${ROOTFS_DIR}/etc/netplan/eth0.yaml <<EOF
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    eth0:
      addresses:
      - 192.168.100.252/24
      dhcp4: no
      routes:
      - to: default
        via: 192.168.100.1
      nameservers:
        addresses:
        - 192.168.100.1
  vlans:
    vlan200:
      id: 200
      link: eth0
      addresses:
      - 192.168.200.252/24
EOF

chmod 600 ${ROOTFS_DIR}/etc/netplan/eth0.yaml
