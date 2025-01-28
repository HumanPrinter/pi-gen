#!/bin/bash -e

omv-confdbadm populate
omv-salt deploy run hosts

omv_set_default "OMV_APT_USE_OS_SECURITY" false true
omv_set_default "OMV_APT_USE_KERNEL_BACKPORTS" false true

wget https://github.com/OpenMediaVault-Plugin-Developers/packages/raw/master/openmediavault-omvextrasorg_latest_all7.deb
dpkg --install openmediavault-omvextrasorg_latest_all7.deb