#!/bin/bash

rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-DSA-KEY.pub
rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub
echo -e "[vmware-tools]\nname=VMware Tools\nbaseurl=http://packages.vmware.com/tools/esx/5.5latest/rhel6/\$basearch\nenabled=1\ngpgcheck=1" > /etc/yum.repos.d/vmware-tools.repo
yum -y install vmware-tools-esx-nox
rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
