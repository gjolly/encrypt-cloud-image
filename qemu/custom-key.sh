#!/bin/bash -eu

curl -LO https://ppa.launchpadcontent.net/ci-train-ppa-service/4870/ubuntu/dists/focal/main/signed/linux-azure-fde-amd64/current/signed.tar.gz

tar xvf signed.tar.gz

openssl x509 -in '5.4.0-1085.90+cvm1.4/control/uefi.crt' -inform PEM -out /var/tmp/ppa-cert.der -outform DER

mokutil --import /var/tmp/ppa-cert.der

echo "reboot now"
