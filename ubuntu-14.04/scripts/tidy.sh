#!/bin/sh


DEBIAN_FRONTEND=noninteractive
UCF_FORCE_CONFFNEW=true
export UCF_FORCE_CONFFNEW DEBIAN_FRONTEND

apt-get remove --purge wpasupplicant
apt-get remove --purge ppp
apt-get remove --purge wireless-tools
apt-get clean && apt-get autoclean && apt-get autoremove
logrotate -fv /etc/logrotate.conf
/bin/cat /dev/null > /var/log/auth
/bin/cat /dev/null > /var/log/wtmp
rm -fr /etc/ssh/ssh_host_*
rm -fr /home/ubuntu/*.deb
/bin/cat /dev/null > /root/.bash_history && history -c
/bin/cat /dev/null > /root/.ssh/authorized_keys
/bin/cat /dev/null > /home/ubuntu/.bash_history
/bin/cat /dev/null > /home/ubuntu/.ssh/authorized_keys
