{ config, pkgs, ... }:

{
  imports =
    [
      ../../nixos
      ../../nixos/bluetooth.nix
      ../../nixos/pipewire.nix
      ../../nixos/kde.nix

      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "monstro";
  networking.networkmanager.enable = true; 

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.manolis.extraGroups = [ "docker" "wheel" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
