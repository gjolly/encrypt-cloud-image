#!/bin/bash -eu

image="$1"

if [ -z "$image" ]; then
  echo "usage: $0 DISK_IMAGE"
  exit 1
fi

############### TPM setup ###############
tpm2_clear

# In theory, should use a secure password
tpm2_changeauth -c owner

tpm2_createek -c ek.ctx
tpm2_createprimary -C o -c ek.ctx -P password

tpm2_evictcontrol -P password -c ek.ctx > handle.yaml
handle="$(grep 'persistent-handle' handle.yaml | cut -d':' -f2 | xargs)"

tpm2_readpublic -c "$handle" -o srk.pub > srk.yaml

############### image setup #############

modprobe nbd
encrypt-cloud-image encrypt -o /tmp/out.vhd "$image"
encrypt-cloud-image deploy --srk-pub ./srk.pub /tmp/out.vhd
