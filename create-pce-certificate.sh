#create-certificate.sh
cat << EOF >> /etc/rc.local
#create certbot_authenticator.sh
cat << EOFa > /.certbot_authenticator.sh
cat << EOFb > /.create_txt_record.json
{
"Changes": [{
"Action": "CREATE",
"ResourceRecordSet": {
"Name": "_acme-challenge.\$CERTBOT_DOMAIN.",
"Type": "TXT",
"TTL": 300,
"ResourceRecords": [{ "Value": "\"\$CERTBOT_VALIDATION\""}]
}}]
}
EOFb
sleep 3
aws route53 change-resource-record-sets --hosted-zone-id \$(cat /.hostedzone) --change-batch file:///.create_txt_record.json
sleep 20
EOFa
chmod +x /.certbot_authenticator.sh
#create certbot_cleanup.sh
cat << EOFc > /.certbot_cleanup.sh
cat << EOFd > /.delete_txt_record.json
{
"Changes": [{
"Action": "DELETE",
"ResourceRecordSet": {
"Name": "_acme-challenge.\$CERTBOT_DOMAIN.",
"Type": "TXT",
"TTL": 300,
"ResourceRecords": [{ "Value": "\"\$CERTBOT_VALIDATION\""}]
}}]
}
EOFd
sleep 3
aws route53 change-resource-record-sets --hosted-zone-id \$(cat /.hostedzone) --change-batch file:///.delete_txt_record.json
EOFc
chmod +x /.certbot_cleanup.sh
#install certbot
yum install -y epel-release
yum install -y certbot
#sleep for creation of dns record on name servers
sleep 10
#create certificate
#if dev, sign with test CAs
if [[ \$(hostname) != *".dev."* ]]; then
    certbot certonly --domain \$(hostname) --manual --preferred-challenges dns --manual-auth-hook /.certbot_authenticator.sh --manual-cleanup-hook /.certbot_cleanup.sh --agree-tos --register-unsafely-without-email --keep-until-expiring --key-type rsa
else
    certbot certonly --domain \$(hostname) --manual --preferred-challenges dns --manual-auth-hook /.certbot_authenticator.sh --manual-cleanup-hook /.certbot_cleanup.sh --agree-tos --register-unsafely-without-email --keep-until-expiring --key-type rsa --test-cert
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
