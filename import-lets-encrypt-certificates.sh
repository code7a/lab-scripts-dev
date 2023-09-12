#import-lets-encrypt-certificates.sh
curl https://letsencrypt.org/certs/isrgrootx1.pem -o /etc/pki/ca-trust/source/anchors/isrgrootx1.pem
curl https://letsencrypt.org/certs/lets-encrypt-r3.pem -o /etc/pki/ca-trust/source/anchors/lets-encrypt-r3.pem
curl https://letsencrypt.org/certs/staging/letsencrypt-stg-int-r3.pem -o /etc/pki/ca-trust/source/anchors/letsencrypt-stg-int-r3.pem
curl https://letsencrypt.org/certs/staging/letsencrypt-stg-int-e1.pem -o /etc/pki/ca-trust/source/anchors/letsencrypt-stg-int-e1.pem
curl https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x1.pem -o /etc/pki/ca-trust/source/anchors/letsencrypt-stg-root-x1.pem
curl https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x2.pem -o /etc/pki/ca-trust/source/anchors/letsencrypt-stg-root-x2.pem
update-ca-trust enable && update-ca-trust extract