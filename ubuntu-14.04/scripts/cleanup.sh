#!/bin/sh


DEBIAN_FRONTEND=noninteractive
UCF_FORCE_CONFFNEW=true
export UCF_FORCE_CONFFNEW DEBIAN_FRONTEND


apt-get -y autoremove
apt-get -y clean

