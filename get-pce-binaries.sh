#get-pce-binaries.sh
yum install -y wget
cd /
if [[ $pce_version == "22.5.23" ]]; then
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.23/pce/pkgs/illumio-pce-22.5.23-2.c8.x86_64.rpm
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.23/pce/pkgs/UI/illumio-pce-ui-22.5.23.UI1-1.x86_64.rpm
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.23/compatibility/illumio-release-compatibility-39-280.tar.bz2
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
elif [[ $pce_version == "23.2.0" ]]; then
    wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/pce/pkgs/illumio-pce-23.2.0-1346.c8.x86_64.rpm
    wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/pce/pkgs/UI/illumio-pce-ui-23.2.0.UI1-1736.x86_64.rpm
    wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/compatibility/illumio-release-compatibility-37-270.tar.bz2
    wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/ven/bundle/illumio-ven-bundle-23.2.0-129.tar.bz2
elif [[ $pce_version == "22.5.20" ]]; then
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.20/pce/pkgs/illumio-pce-22.5.20-136.c8.x86_64.rpm
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.20/pce/pkgs/UI/illumio-pce-ui-22.5.20.UI1-166.x86_64.rpm
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.20/compatibility/illumio-release-compatibility-35-256.tar.bz2
    wget --timestamping https://$repo/22.5/GA%20Releases/22.5.20/ven/bundle/illumio-ven-bundle-22.5.20-9798.tar.bz2
elif [[ $pce_version == "22.2.40" ]]; then
    wget --timestamping https://$repo/22.2/GA%20Releases/22.2.40/pce/pkgs/illumio-pce-22.2.40-663.c8.x86_64.rpm
    wget --timestamping https://$repo/22.2/GA%20Releases/22.2.40/pce/pkgs/UI/illumio-pce-ui-22.2.40.UI1-460.x86_64.rpm
    wget --timestamping https://$repo/22.2/GA%20Releases/22.2.41/compatibility/illumio-release-compatibility-31-240.tar.bz2
    wget --timestamping https://$repo/22.2/GA%20Releases/22.2.41/ven/bundle/illumio-ven-bundle-22.2.41-9192.tar.bz2
elif [[ $pce_version == "21.5.35" ]]; then
    wget --timestamping https://$repo/21.5/GA%20Releases/21.5.35/pce/pkgs/illumio-pce-21.5.35-9.c8.x86_64.rpm
    wget --timestamping https://$repo/21.5/GA%20Releases/21.5.35/pce/pkgs/UI/illumio-pce-ui-21.5.35.UI1-1.x86_64.rpm
    wget --timestamping https://$repo/21.5/GA%20Releases/21.5.35/compatibility/illumio-release-compatibility-34-254.tar.bz2
    wget --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
fi
cd
