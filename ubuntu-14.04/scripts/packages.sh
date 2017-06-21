#!/bin/sh


DEBIAN_FRONTEND=noninteractive
UCF_FORCE_CONFFNEW=true
export UCF_FORCE_CONFFNEW DEBIAN_FRONTEND

apt-get clean && apt-get autoclean && apt-get autoremove
apt-get update
apt-get -y dist-upgrade

PACKAGES="
apt-transport-https
build-essential
curl
dkms
git
grub2
htop
libpam-cracklib
cracklib-runtime
libcrack2
libpam-cracklib
wamerican
kpartx
python-pip
tcpdump
unzip
vim-nox
"
apt-get -y install $PACKAGES
apt-get -y install linux-headers-$(uname -r)
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" dist-upgrade
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install ruby1.9.3

## Workaround for https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991 -ACG
cd /tmp
easy_install -U pip
# pip install docker-py
# pip install awscli
apt-get clean
apt-get autoremove