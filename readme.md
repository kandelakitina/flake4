## Installation

### VM

- Download NixOS installer from official web-site
- Run `virt-manager` (don't forget to enable 4d uefi in custom config) with the installer iso
- In the VM: close the installer and open terminal
- `git clone` this repo
- Run `partitionWithDisko.sh` and partition the disk
- Run `sudo nixos-install --flake .#vm`