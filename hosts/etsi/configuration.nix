{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos
    ../../nixos/docker.nix
    ../../nixos/systemd-boot.nix

    ./hardware-configuration.nix
  ];

  # install latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # disable zram swap
  zramSwap.enable = lib.mkForce false;

  networking.hostName = "etsi";
  networking.interfaces.eno1.wakeOnLan.enable = true;

  users = {
    groups = {
      anthi = {
        gid = 1001;
      };
    };

    users = {
      anthi = {
        isNormalUser = true;
        uid = 1001;
        group = "anthi";
        createHome = true;
        home = "/home/anthi";
        initialPassword = "password";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
