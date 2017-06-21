#!/bin/sh


DEBIAN_FRONTEND=noninteractive
UCF_FORCE_CONFFNEW=true
export UCF_FORCE_CONFFNEW DEBIAN_FRONTEND


mkdir /opt/firstboot
cd /opt/firstboot
curl -O https:///deployment/linux/firstboot/rsyncvols.sh
rm -fr /etc/salt/minion
rm -fr /srv/salt

cat > /etc/rc.local << "EOF"
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server
test -f /opt/firstboot || /bin/bash /opt/firstboot/rsyncvols.sh
test -f /var/log/masterlessrun.tmp || rm -fr /srv/salt
test -f /var/log/firstboot.tmp || rm -fr /opt/firstboot
exit 0
EOF