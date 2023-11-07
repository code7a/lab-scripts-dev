#suse-vm-base-install.sh
zypper install -n -y sysvinit-tools
wget https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.5/repo/oss/x86_64/sysvinit-tools-2.99-1.1.x86_64.rpm && rpm -ivh sysvinit-tools-2.99-1.1.x86_64.rpm
zypper install -n -y net-tools-deprecated
wget https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.5/repo/oss/x86_64/net-tools-deprecated-2.0+git20170221.479bb4a-3.11.x86_64.rpm && rpm -ivh net-tools-deprecated-2.0+git20170221.479bb4a-3.11.x86_64.rpm
