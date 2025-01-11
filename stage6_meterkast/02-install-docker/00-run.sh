#!/bin/bash -e

curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o ${ROOTFS_DIR}/etc/apt/keyrings/docker.asc
chmod a+r ${ROOTFS_DIR}/etc/apt/keyrings/docker.asc

cat > ${ROOTFS_DIR}/etc/apt/sources.list.d/docker.list <<EOF
deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable
EOF

on_chroot << EOF
apt update
EOF
