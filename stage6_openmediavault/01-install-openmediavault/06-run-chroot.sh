#!/bin/bash -e

omv_config_update "/config/services/ssh/enable" "1"
omv_config_update "/config/services/ssh/permitrootlogin" "1"
omv_config_update "/config/system/time/ntp/enable" "1"
omv_config_update "/config/system/time/timezone" "${TIMEZONE_DEFAULT}"
omv_config_update "/config/system/network/dns/hostname" "${TARGET_HOSTNAME}"

/usr/sbin/omv-rpc -u admin "perfstats" "set" '{"enable":false}'
/usr/sbin/omv-rpc -u admin "config" "applyChanges" '{ "modules": ["monit","rrdcached","collectd"],"force": true }'

omv_set_default "OMV_WATCHDOG_SYSTEMD_RUNTIMEWATCHDOGSEC" "14s" true

MIN_SPEED="$(</sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq)"
MAX_SPEED="$(</sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq)"

cat << EOF > /etc/default/cpufrequtils
GOVERNOR="schedutil"
MIN_SPEED="${MIN_SPEED}"
MAX_SPEED="${MAX_SPEED}"
EOF

modprobe --quiet configs

defaultGov="$(grep "^CONFIG_CPU_FREQ_DEFAULT_GOV_" /boot/config-$(uname -r) | sed -e "s/^CONFIG_CPU_FREQ_DEFAULT_GOV_\(.*\)=y/\1/")"

. /etc/default/cpufrequtils

omv_set_default "OMV_CPUFREQUTILS_GOVERNOR" "${GOVERNOR}"
omv_set_default "OMV_CPUFREQUTILS_MINSPEED" "${MIN_SPEED}"
omv_set_default "OMV_CPUFREQUTILS_MAXSPEED" "${MAX_SPEED}"

omv-salt stage run prepare

omv-salt deploy run nginx phpfpm samba flashmemory ssh chrony timezone monit rrdcached collectd cpufrequtils apt watchdog

mkdir --parents --mode=0755 /var/lib/php/modules
mkdir --parents --mode=1733 /var/lib/php/sessions

usermod -aG openmediavault-admin ${FIRST_USER_NAME}
