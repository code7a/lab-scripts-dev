#create-certificate.sh
cat << EOF >> /etc/rc.local
#sleep for creation of dns record on name servers
sleep 10
#create certificate
#if dev, sign with test CAs
if [[ \$(hostname) != *".dev."* ]]; then
    certbot certonly --domain \$(hostname) --manual --preferred-challenges dns --manual-auth-hook /.certbot_authenticator.sh --manual-cleanup-hook /.certbot_cleanup.sh --agree-tos --register-unsafely-without-email --force-renewal --key-type rsa
else
    certbot certonly --domain \$(hostname) --manual --preferred-challenges dns --manual-auth-hook /.certbot_authenticator.sh --manual-cleanup-hook /.certbot_cleanup.sh --agree-tos --register-unsafely-without-email --force-renewal --key-type rsa --test-cert
fi
certbot_result=\$(echo \$?)
#if error, sleep 60, retry
echo \$certbot_result | grep 0 || sleep 60 && certbot certonly --domain \$(hostname) --manual --preferred-challenges dns --manual-auth-hook /.certbot_authenticator.sh --manual-cleanup-hook /.certbot_cleanup.sh --agree-tos --register-unsafely-without-email --force-renewal --key-type rsa --test-cert
#copy, set permissions
echo y|cp /etc/letsencrypt/live/\$(hostname)/cert.pem /var/lib/illumio-pce/cert/server.crt
echo y|cp /etc/letsencrypt/live/\$(hostname)/privkey.pem /var/lib/illumio-pce/cert/server.key
chmod 400 /var/lib/illumio-pce/cert/server.key
chown ilo-pce:ilo-pce /var/lib/illumio-pce/cert/server.key
EOF