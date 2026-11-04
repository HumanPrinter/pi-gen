#!/bin/bash -e

curl -fsSL https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install -o ${ROOTFS_DIR}/home/oscar/install.sh
chmod +w ${ROOTFS_DIR}/home/oscar/install.sh
