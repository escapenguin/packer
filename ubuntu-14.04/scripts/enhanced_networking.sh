#!/bin/sh


curl -O "https://deployment/linux/enhanced_networking/ixgbevf-2.16.1.tar.gz"
tar -xzf ixgbevf-2.16.1.tar.gz
mv ixgbevf-2.16.1 /usr/src/
rm -fr ixgbevf*
cd /usr/src/ixgbevf-2.16.1/src
curl -O "https://deployment/linux/enhanced_networking/patch-ubuntu_14.04.1-ixgbevf-2.16.1-kcompat.h.patch"
patch -p5 < patch-ubuntu_14.04.1-ixgbevf-2.16.1-kcompat.h.patch
touch /usr/src/ixgbevf-2.16.1/dkms.conf

cat > /usr/src/ixgbevf-2.16.1/dkms.conf << "EOF"
PACKAGE_NAME="ixgbevf"
PACKAGE_VERSION="2.16.1"
CLEAN="cd src/; make clean"
MAKE="cd src/; make BUILD_KERNEL=${kernelver}"
BUILT_MODULE_LOCATION[0]="src/"
BUILT_MODULE_NAME[0]="ixgbevf"
DEST_MODULE_LOCATION[0]="/updates"
DEST_MODULE_NAME[0]="ixgbevf"
AUTOINSTALL="yes"
EOF

modprobe ixgbevf
dkms add -m ixgbevf -v 2.16.1 &&
dkms build -m ixgbevf -v 2.16.1 &&
dkms install -m ixgbevf -v 2.16.1 &&
update-initramfs -c -k all
echo "options ixgbevf InterruptThrottleRate=1,1,1,1,1,1,1,1" > /etc/modprobe.d/ixgbevf.conf
echo "ixgbevf" >> /etc/modules