{
  imports = [
    ../../nixos
    ../../nixos/docker.nix
    ../../nixos/mergerfs.nix
    ../../nixos/restic.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/users-home.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "etsi";
  networking.interfaces.eno1.wakeOnLan.enable = true;

  services.snapraid = {
    enable = true;
    dataDisks = {
      d1 = "/mnt/pool/slot1";
      d2 = "/mnt/pool/slot2";
      d3 = "/mnt/pool/slot3";
    };
    contentFiles = [
      "/var/snapraid.content"
      "/mnt/pool/slot1/.snapraid.content"
      "/mnt/pool/slot2/.snapraid.content"
      "/mnt/pool/slot3/.snapraid.content"
    ];
    parityFiles = [
      "/mnt/parity/snapraid.parity"
    ];
    exclude = [
      "*.unrecoverable"
      "/tmp/"
      "/lost+found/"
    ];
    sync.interval = "daily";
    scrub.interval = "weekly";
  };

  services.restic.backups.periodic.paths = [
    "/var/services"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
