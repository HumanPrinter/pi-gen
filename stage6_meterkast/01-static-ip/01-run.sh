#!/bin/bash -e

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
EOF

chmod 600 ${ROOTFS_DIR}/etc/netplan/eth0.yaml
