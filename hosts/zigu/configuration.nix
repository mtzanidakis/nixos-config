{ config, pkgs, ... }:

{
  imports = [
    ../../nixos
    ../../nixos/intel_gpu.nix
    ../../nixos/bluetooth.nix
    ../../nixos/docker.nix
    ../../nixos/extrahosts.nix
    ../../nixos/flatpak.nix
    ../../nixos/fonts.nix
    #../../nixos/fprintd.nix
    ../../nixos/kde.nix
    ../../nixos/pipewire.nix
    ../../nixos/printing.nix
    ../../nixos/steam.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/virt-manager.nix
    ../../nixos/zramswap.nix

    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "zigu";
    networkmanager.enable = true;
  };

  virtualisation.docker.storageDriver = "btrfs";
  services.btrfs.autoScrub.enable = true;

  services.udev.packages = with pkgs; [
    trezor-udev-rules
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
