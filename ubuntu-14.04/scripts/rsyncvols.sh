#!/bin/bash -x


###
## Quick and dirty script for migrating / and /boot to fresh volumes to get around AWS' encryption limitation.
## This script assumes defaults for what's created with the template_multivol Packer template.
## There be dragons.
###

#test ! -e /var/log/firstboot.tmp || exit 0
#touch /var/log/firstboot.tmp &&
fdisk -l
sleep 5
/bin/echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/xvdb
/bin/echo -e "a\n1\nw" | fdisk /dev/xvdb
mkfs.ext4 /dev/xvdb1
mkdir /mnt/newroot
mount /dev/xvdb1 /mnt/newroot

rsync -aqzHPAX --exclude '/boot' \
--exclude '/opt/*' \
--exclude '/proc' \
--exclude '/root/*' \
--exclude '/run' \
--exclude '/var/cache/*' \
--exclude '/var/run/*' \
--exclude '/var/spool/*' \
--exclude '/var/tmp/*' \
--exclude '/tmp/*' \
--exclude '/sys' \
--exclude '/mnt/newroot' / /mnt/newroot

/bin/echo -e "/dev/xvda1 /boot ext4 defaults 0 0" > /mnt/newroot/etc/fstab
/bin/echo -e "/dev/xvdb1 / ext4 defaults 0 0" >> /mnt/newroot/etc/fstab
mkdir /mnt/newroot/{proc,run,sys}

###
## Set up new /boot volume
###
/bin/echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/xvdf
/bin/echo -e "a\n1\nw" | fdisk /dev/xvdf
mkfs.ext4 /dev/xvdf1
mkdir /mnt/newboot
mount /dev/xvdf1 /mnt/newboot
rsync -aqzHPAX /boot/ /mnt/newboot
umount /mnt/newboot
umount /boot
mount /dev/xvdf1 /boot

###
## Mangle grub
###
sed -i 's/console=hvc0/console=ttyS0/' /boot/grub/menu.lst
sed -i 's/#GRUB_DISABLE_LINUX_UUID=true/GRUB_DISABLE_LINUX_UUID=true/' /mnt/newroot/etc/default/grub
/bin/echo -e "GRUB_DEVICE=/dev/xvdb1" >> /mnt/newroot/etc/default/grub
grub-install /dev/xvda && grub-install /dev/xvdb && grub-install /dev/xvdf && update-grub2
update-initramfs -c -k all
umount /boot
umount /mnt/newroot
rm -fr /mnt/newroot
rm -fr /mnt/newboot
mount -a
sync; sync; sync
#rm $0
#shutdown -h now
## detach all volumes
## attach newboot as /dev/sda1
## attach newroot as /dev/sdb
