================
packer-templates
================

Packer templates for building VMware templates and Amazon AWS AMIs.


Installing Packer
-----------------

Download and install the latest version of packer from:  http://www.packer.io/downloads.html.

Install on OS X with Homebrew:

::

    $ brew tap homebrew/binary
    $ brew install packer
    $ brew install https://raw.githubusercontent.com/packer-community/packer-windows-plugins-brew/master/packer-windows-plugins.rb

Installing on Windows with Chocolatey:

::

    $ choco install packer
    $ choco install packer-windows-plugins

Clone packer-templates
----------------------

::

    $ git clone https://packer-templates

Building images
---------------

Base Ubuntu LTS 14.04 VMware build:

::

    $ packer build -parallel=true -only=vmware-iso template.json

Base Ubuntu LTS 14.04 Virtualbox build:

::

    $ packer build -parallel=true -only=virtualbox-iso template.json

Base Windows VMware templates:

::

    $ packer build -parallel=true -only-vmware-windows-iso win2012r2-datacenter.json
    $ packer build -parallel=true -only-vmware-windows-iso win2012r2-standard.json
    $ packer build -parallel=true -only-vmware-windows-iso win2008r2-datacenter.json
    $ packer build -parallel=true -only-vmware-windows-iso win2008r2-standard.json

AWS build with EBS-backed storage and the HVM hypervisor (to build with pv virtualization, just change aws_instance_type to a pv compatible type):

::

    $ PACKER_LOG=1 packer -debug build -only=amazon-ebs \
    -var "aws_access_key=<your_access_key>" \
    -var "aws_ami_description=ubuntu-1404-amd64-en" \
    -var "aws_iam_instance_profile=packer-deploy" \
    -var "aws_instance_type=<>" \
    -var "aws_region=us-west-2" \
    -var "aws_secret_key=<your_secret_key>" \
    -var "aws_source_ami=<>" \
    -var "aws_subnet_id=<>" \
    -var "aws_account_id=<>" \
    -var "aws_vpc_id=<>" template.json

AWS build with instance-backed storage and the hvm hypervisor with enhanced networking enabled:

::

    $ PACKER_LOG=1 packer build -only=amazon-instance \
	-var "aws_access_key=<your_access_key>" \
	-var "aws_secret_key=<your_secret_key>" \
	-var "aws_region=<your_desired_region>" \
	-var "aws_source_ami=<>" \
	-var "aws_iam_instance_profile=packer-deploy" \
	-var "aws_s3_bucket=<bucket_for_AMI_template_to_live_in>" \
	-var "aws_x509_cert_path=<local_path_to_your_cert>" \
	-var "aws_x509_key_path=<local_path_to_your_pem>" \
	-var "aws_subnet_id=<subnet_id>" \
	-var "aws_ami_description=<ami_description>" \
	-var "aws_account_id=<>" \
	-var "aws_vpc_id=<vpic_id>" template.json


Caveats
-------
 * Creating VMware templates currently requires VMware Workstation. VMware Player and the ESXi providers are currently broken (on Windows 8.1 at least).
 * Building Windows images on non-Windows platforms is untested since the current plug-ins used are Windows binaries.
 * The current release of packer-windows-plugins is bugged, and will cause any build to error out after running shutdown_command on Windows builds.
    https://github.com/packer-community/packer-windows-plugins/issues/51
    These binaries fix the issue for now (Windows only as of 06012015):
    https://github.com/packer-community/packer-windows-plugins/releases/tag/pre-release

TODO:
-----
 * Clean up 2012r2-datacenter template
 * Update 2012r2-standard with datacenter template fixes
 * Add template for 2k8
 * Fix Linux partitioning on Ubuntu
 * Harden templates
 * Local repo set up to host ISOs
 * Add Windows update
 * Add AMI builder to Windows templates

Supported versions
------------------

Tested using packer 0.7.5.

Initially forked from:  https://github.com/shiguredo/packer-templates

Also borrowed a lot from this nice repo:  https://github.com/boxcutter/windows
