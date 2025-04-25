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

  networking = {
    hostName = "etsi";
    interfaces.enp1s0.wakeOnLan.enable = true;
    firewall = {
      allowedTCPPorts = [
        45876 # beszel
      ];
    };
  };

  services.snapraid = {
    enable = true;
    dataDisks = {
      d1 = "/mnt/pool/slot1";
      d2 = "/mnt/pool/slot2";
      d3 = "/mnt/pool/slot3";
      d4 = "/mnt/pool/slot4";
      d5 = "/mnt/pool/slot5";
    };
    contentFiles = [
      "/var/snapraid.content"
      "/mnt/pool/slot1/.snapraid.content"
      "/mnt/pool/slot2/.snapraid.content"
      "/mnt/pool/slot3/.snapraid.content"
      "/mnt/pool/slot4/.snapraid.content"
      "/mnt/pool/slot5/.snapraid.content"
    ];
    parityFiles = [
      "/mnt/parity/snapraid.parity"
    ];
    exclude = [
      "*.unrecoverable"
      "/tmp/"
      "/lost+found/"
      "/mnt/pool/*/downloads/incomplete/"
      "/mnt/pool/*/downloads/slskd/"
    ];
    sync.interval = "*-*-* 00/4:00:00";
    scrub.interval = "weekly";
  };

  services.restic.backups.periodic.paths = [
    "/var/services"
  ];

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "etsi";
        "netbios name" = "etsi";
        "security" = "user";
        "use sendfile" = "yes";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "storage" = {
        "path" = "/mnt/storage";
        "read only" = "no";
        "guest ok" = "no";
        "browseable" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.scrutiny = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
