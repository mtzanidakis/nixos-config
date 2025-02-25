{lib, ...}: {
  imports = [
    ../../nixos
    ../../nixos/nvidia1xxx_gpu.nix
    ../../nixos/bluetooth.nix
    ../../nixos/docker.nix
    ../../nixos/flatpak.nix
    ../../nixos/fonts.nix
    ../../nixos/kde.nix
    ../../nixos/pipewire.nix
    ../../nixos/printing.nix
    ../../nixos/steam.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/zramswap.nix
    ../../nixos/users-home.nix

    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "paku";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  virtualisation.docker.storageDriver = "btrfs";
  services.btrfs.autoScrub.enable = true;
  services.xserver.xkb.options = lib.mkForce "grp:alt_shift_toggle,terminate:ctrl_alt_bksp";
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "aris";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
