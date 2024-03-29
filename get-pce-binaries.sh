#get-pce-binaries.sh
yum install -y wget
cd /
if [[ $pce_version == "23.5.10" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.5/GA%20Releases/23.5.10/pce/pkgs/illumio-pce-23.5.10-107.el9.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.5/GA%20Releases/23.5.10/pce/pkgs/UI/illumio-pce-ui-23.5.10.UI1-117.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/342/illumio-release-compatibility-53-342.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "23.4.2" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.4/GA%20Releases/23.4.2/pce/pkgs/illumio-pce-23.4.2-4.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.4/GA%20Releases/23.4.2/pce/pkgs/UI/illumio-pce-ui-23.4.2.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "23.4.0" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.4/GA%20Releases/23.4.0/pce/pkgs/illumio-pce-23.4.0-1631.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.4/GA%20Releases/23.4.0/pce/pkgs/UI/illumio-pce-ui-23.4.0.UI1-2225.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "23.3.2" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.3/GA%20Releases/23.3.2/pce/software/illumio-pce-sw-23.3.2-10.c7.tgz
    wget --no-check-certificate --timestamping https://$repo/23.3/GA%20Releases/23.3.2+UI2/pce/pkgs/UI/illumio-pce-ui-23.3.2.UI2-15.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
elif [[ $pce_version == "23.3.0" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.3/GA%20Releases/23.3.0/pce/pkgs/illumio-pce-23.3.0-1483.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.3/GA%20Releases/23.3.0/pce/pkgs/UI/illumio-pce-ui-23.3.0.UI1-2009.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
elif [[ $pce_version == "23.2.11" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.11/pce/pkgs/illumio-pce-23.2.11-2.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.11/pce/pkgs/UI/illumio-pce-ui-23.2.11.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
elif [[ $pce_version == "23.2.10" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/pce/pkgs/illumio-pce-23.2.10-94.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/pce/pkgs/UI/illumio-pce-ui-23.2.10.UI1-143.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.10/ven/bundle/illumio-ven-bundle-23.2.10-205.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
elif [[ $pce_version == "23.2.0" ]]; then
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.0/pce/pkgs/illumio-pce-23.2.0-1346.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.0/pce/pkgs/UI/illumio-pce-ui-23.2.0.UI1-1736.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo_compatibility/337/illumio-release-compatibility-51-337.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.22/ven/bundle/illumio-ven-bundle-23.2.22-290.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/23.2/GA%20Releases/23.2.0/ven/bundle/illumio-ven-bundle-23.2.0-129.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
elif [[ $pce_version == "22.5.31" ]]; then
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.31/pce/pkgs/illumio-pce-22.5.31-2.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.31/pce/pkgs/UI/illumio-pce-ui-22.5.31.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.23/compatibility/illumio-release-compatibility-39-280.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.30/ven/bundle/illumio-ven-bundle-22.5.30-9870.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "22.5.30" ]]; then
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.30/pce/pkgs/illumio-pce-22.5.30-181.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.30/pce/pkgs/UI/illumio-pce-ui-22.5.30.UI1-186.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.23/compatibility/illumio-release-compatibility-39-280.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.30/ven/bundle/illumio-ven-bundle-22.5.30-9870.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "22.5.23" ]]; then
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.23/pce/pkgs/illumio-pce-22.5.23-2.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.23/pce/pkgs/UI/illumio-pce-ui-22.5.23.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.23/compatibility/illumio-release-compatibility-39-280.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.22/ven/bundle/illumio-ven-bundle-22.5.22-9806.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "22.5.20" ]]; then
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.20/pce/pkgs/illumio-pce-22.5.20-136.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.20/pce/pkgs/UI/illumio-pce-ui-22.5.20.UI1-166.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.20/compatibility/illumio-release-compatibility-35-256.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.5/GA%20Releases/22.5.20/ven/bundle/illumio-ven-bundle-22.5.20-9798.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "22.2.42" ]]; then
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.42/pce/pkgs/illumio-pce-22.2.42-2.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.42/pce/pkgs/UI/illumio-pce-ui-22.2.42.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.43/compatibility/illumio-release-compatibility-43-300.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.43/ven/bundle/illumio-ven-bundle-22.2.43-9197.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.41/ven/bundle/illumio-ven-bundle-22.2.41-9192.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "22.2.40" ]]; then
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.40/pce/pkgs/illumio-pce-22.2.40-663.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.40/pce/pkgs/UI/illumio-pce-ui-22.2.40.UI1-460.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.41/compatibility/illumio-release-compatibility-31-240.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/22.2/GA%20Releases/22.2.41/ven/bundle/illumio-ven-bundle-22.2.41-9192.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
elif [[ $pce_version == "21.5.36" ]]; then
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.36/pce/pkgs/illumio-pce-21.5.36-2.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.36/pce/pkgs/UI/illumio-pce-ui-21.5.36.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.35/compatibility/illumio-release-compatibility-34-254.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.2/GA%20Releases/21.2.5/ven/bundle/illumio-ven-bundle-21.2.5-8017.tar.bz2
elif [[ $pce_version == "21.5.35" ]]; then
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.35/pce/pkgs/illumio-pce-21.5.35-9.c8.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.35/pce/pkgs/UI/illumio-pce-ui-21.5.35.UI1-1.x86_64.rpm
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.35/compatibility/illumio-release-compatibility-34-254.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.5/GA%20Releases/21.5.32/ven/bundle/illumio-ven-bundle-21.5.32-8533.tar.bz2
    wget --no-check-certificate --timestamping https://$repo/21.2/GA%20Releases/21.2.5/ven/bundle/illumio-ven-bundle-21.2.5-8017.tar.bz2
fi
cd
