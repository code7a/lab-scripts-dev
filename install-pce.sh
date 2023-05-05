#install-pce.sh
#modify to get bin repo script
yum install -y wget bzip2 net-tools initscripts libxcrypt-compat compat-openssl11 glibc-langpack-en
localectl set-locale LANG=en_US.utf8

cd /
wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/pce/pkgs/illumio-pce-23.2.0-1346.c8.x86_64.rpm
wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/pce/pkgs/UI/illumio-pce-ui-23.2.0.UI1-1736.x86_64.rpm
wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/compatibility/illumio-release-compatibility-37-270.tar.bz2
wget --timestamping https://$repo/23.2/GA%20Releases/23.2.0/ven/bundle/illumio-ven-bundle-23.2.0-129.tar.bz2
cd
rpm -Uvh /illumio-pce-*.rpm
#mkdir /opt/illumio-pce/ && tar -xf illumio-pce-*.tgz -C /opt/illumio-pce/ && chown -R root:ilo-pce /opt/illumio-pce/

#file kernal settings

echo y|cp /etc/letsencrypt/live/$(hostname)/cert.pem /var/lib/illumio-pce/cert/server.crt
echo y|cp /etc/letsencrypt/live/$(hostname)/privkey.pem /var/lib/illumio-pce/cert/server.key
chmod 400 /var/lib/illumio-pce/cert/server.key
chown ilo-pce:ilo-pce /var/lib/illumio-pce/cert/server.key

/opt/illumio-pce/illumio-pce-env setup --batch node_type='snc0' email_address=$pce_admin_username_email_address pce_fqdn=$(hostname) metrics_collection_enabled=false expose_user_invitation_link=true
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl start --runlevel 1 #&> /dev/null
sleep 60
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl status -w
sleep 10
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl status -w
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-db-management setup
sleep 10
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl set-runlevel 5 #&> /dev/null
sleep 60
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl status -w
sleep 10
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl status -w
#create domain
sudo --preserve-env -u ilo-pce ILO_PASSWORD=$pce_admin_password /opt/illumio-pce/illumio-pce-db-management create-domain --user-name $pce_admin_username_email_address --full-name admin --org-name $(hostname)
#install ven bundle
sudo -u ilo-pce /opt/illumio-pce/illumio-pce-ctl ven-software-install /illumio-ven-bundle-* --compatibility-matrix /illumio-release-compatibility-* --default --no-prompt --orgs 1
#sleep 10 && systemctl restart sshd &
#pkill sshd &