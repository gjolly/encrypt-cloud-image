#!/bin/bash -eu

apt-get update
apt-get install -y tpm2-tools golang

git clone https://github.com/canonical/encrypt-cloud-image

cd encrypt-cloud-image/create-uefi-config

go build .

./create-uefi-config -o /home/ubuntu/uefi-config.json

tpm2_createprimary -c key.context
tpm2_readpublic -c key.context -o /home/ubuntu/srk.pub
