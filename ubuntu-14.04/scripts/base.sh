#!/bin/sh


DEBIAN_FRONTEND=noninteractive
UCF_FORCE_CONFFNEW=true
export UCF_FORCE_CONFFNEW DEBIAN_FRONTEND


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
exit 0
EOF