# QEMU

 1. Make sure `/dev/tpm0` is present
 2. Look into [tpm_magic.sh](./tpm_magic.sh) to configure your TPM and encrypt the image, better doing that manually for now
 3. Modify [start-vm.sh](./start-vm.sh) to set your own key in the `user-data.yaml`
 4. Run [start-vm.sh](./start-vm.sh)
