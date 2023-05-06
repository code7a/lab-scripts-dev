#import-lets-encrypt-certificates.ps1
Invoke-WebRequest https://letsencrypt.org/certs/isrgrootx1.pem -o isrgrootx1.pem
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root\ .\isrgrootx1.pem
Invoke-WebRequest https://letsencrypt.org/certs/lets-encrypt-r3.pem -o lets-encrypt-r3.pem
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root\ .\lets-encrypt-r3.pem
Invoke-WebRequest https://letsencrypt.org/certs/staging/letsencrypt-stg-int-r3.pem -o letsencrypt-stg-int-r3.pem
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root\ .\letsencrypt-stg-int-r3.pem
Invoke-WebRequest https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x1.pem -o letsencrypt-stg-root-x1.pem
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root\ .\letsencrypt-stg-root-x1.pem
Invoke-WebRequest https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x2.pem -o letsencrypt-stg-root-x2.pem
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root\ .\letsencrypt-stg-root-x2.pem