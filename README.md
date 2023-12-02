# nixos-config

NixOS Configurations for my systems, using [Flakes](https://nixos.wiki/wiki/Flakes) and [Home Manager](https://nix-community.github.io/home-manager/).

## Install a new system

Boot a NixOS installation media, format the drive and mount root partition on `/mnt` and all additional partitions under this path. 

Clone this repository and run `nixos-install --flake .#HOSTNAME` to install `HOSTNAME` system.

## Update the system

On this repo run `make ls-updates` to get a list of packages that will be updated, and `sudo make deploy` to install them and switch the system to the new configuration. To install the upgrades but switch to the new configuration on the next reboot, instead run `sudo make deploy-boot`.

To directly upgrade all packages and switch to the new configuration without showing changes, run `sudo make upgrade`.

## Cleanup

To remove old configurations and clean up the system, run `make gc-old`. To only remove unreachable objects, run `make gc`.
