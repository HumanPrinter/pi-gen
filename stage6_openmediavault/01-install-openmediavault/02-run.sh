#!/bin/bash -e

curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o ${ROOTFS_DIR}/etc/apt/keyrings/docker.asc
chmod a+r ${ROOTFS_DIR}/etc/apt/keyrings/docker.asc
wget --quiet --output-document=- "http://packages.openmediavault.org/public/archive.key" | gpg --dearmor --yes --output "${ROOTFS_DIR}/etc/apt/keyrings/openmediavault-archive-keyring.gpg"


cat > ${ROOTFS_DIR}/etc/apt/sources.list.d/openmediavault.list <<EOF
deb [signed-by=/etc/apt/keyrings/openmediavault-archive-keyring.gpg] http://packages.openmediavault.org/public sandworm main
EOF

on_chroot << EOF
apt update
EOF
