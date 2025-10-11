{pkgs, ...}: {
  imports = [
    ../../nixos
    ../../nixos/amd_gpu.nix
    ../../nixos/bluetooth.nix
    ../../nixos/docker.nix
    ../../nixos/devenv.nix
    ../../nixos/extrahosts.nix
    ../../nixos/flatpak.nix
    ../../nixos/fonts.nix
    ../../nixos/fprintd.nix
    ../../nixos/kde.nix
    #../../nixos/ollama.nix
    ../../nixos/pipewire.nix
    ../../nixos/printing.nix
    ../../nixos/steam.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/virt-manager.nix
    ../../nixos/zramswap.nix

    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "gizu";
    networkmanager.enable = true;
  };

  virtualisation.docker = {
    storageDriver = "btrfs";
    daemon.settings = {
      ipv6 = true;
      fixed-cidr-v6 = "fd00::/80";
    };
  };

  services.btrfs.autoScrub.enable = true;

  services.udev.packages = with pkgs; [
    trezor-udev-rules
  ];

  #services.ollama = {
    #acceleration = "rocm";
    #rocmOverrideGfx = "11.0.2";
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
