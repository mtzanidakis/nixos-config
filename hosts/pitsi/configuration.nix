{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos
    ../../nixos/docker.nix
    ../../nixos/systemd-boot.nix

    ./hardware-configuration.nix
  ];

  users.users.manolis.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7wZQ2vg+fcPbKMP8B6q1rIpwplVnsK6QiinxnXfEr5"
  ];

  networking.hostName = "pitsi";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
