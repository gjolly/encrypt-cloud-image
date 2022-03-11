#!/bin/bash -eu

# Custumize an Azure VHD to replace the cloud-init datasource
# by NoCloud. This allow the VM to be configured for a local
# use.

IMAGE="$1"

if [ -z "$IMAGE" ]; then
  echo "Usage: $0 DISK_IMAGE"
  exit 1
fi

modprobe nbd
qemu-nbd --connect=/dev/nbd1 --format=vpc "$IMAGE"
mountpoint="$(mktemp -d)"

clean() {
  set +e

  umount "$mountpoint"
  qemu-nbd --disconnect /dev/nbd1
  rm -rf "$mountpoint"
}

trap clean EXIT

# nbd beeing asynchronous, we need to give it some time
sleep 2

mount /dev/nbd1p1 "$mountpoint"
sed -i 's/Azure/NoCloud/g' "$mountpoint/etc/cloud/cloud.cfg.d/90_dpkg.cfg"
