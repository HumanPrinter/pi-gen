#!/bin/bash -e

on_chroot << EOF
usermod -aG docker ${FIRST_USER_NAME}

docker network create -d ipvlan --subnet=192.168.200.0/24 --gateway=192.168.200.1 -o parent=eth0.200 iot
EOF
