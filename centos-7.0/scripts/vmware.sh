#!/bin/bash

yum -y install open-vm-tools
yum -y install open-vm-tools-deploypkg
systemctl enable vmtoolsd
systemctl restart vmtoolsd
