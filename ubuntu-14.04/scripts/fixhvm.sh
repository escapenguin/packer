#!/bin/bash -x


# ec2-bundle-vol requires legacy grub and there should be no console setting (only amazon-instance might need this)
# apt-get -y install grub
# sed -i 's/console=hvc0/console=ttyS0/' /boot/grub/menu.lst
# the above is sufficient to fix 12.04 but 14.04 also needs the following
# sed -i 's/LABEL=UEFI.*//' /etc/fstab

cd /var/tmp
mkdir ami_tools java api_tools ec2
mkdir ec2/bin ec2/lib ec2/etc
export EC2_HOME=/var/tmp/ec2/bin
export JAVA_HOME=/var/tmp/java/jdk1.8.0_05/bin
export PATH=$PATH:$EC2_HOME:$JAVA_HOME
wget "https://deployment/linux/server-jre-8u5-linux-x64.gz"
tar -xzf server-jre-8u5-linux-x64.gz
mv ./jdk1.8.0_05 ./java
cd ./ami_tools
wget "http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools-1.5.7.zip"
unzip -q ec2-ami-tools-1.5.7.zip
cd ../api_tools
wget "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip"
unzip -q ec2-api-tools.zip
cd ..
mv ami_tools/ec2-ami-tools*/bin/* api_tools/ec2-api-tools*/bin/* ec2/bin/
mv ami_tools/ec2-ami-tools*/lib/* api_tools/ec2-api-tools*/lib/* ec2/lib/
mv ami_tools/ec2-ami-tools*/etc/* ec2/etc/
rm -fr /var/tmp/* /tmp/*