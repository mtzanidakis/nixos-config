{lib, ...}: {
  imports = [
    ../../nixos
    ../../nixos/docker.nix
    ../../nixos/opensmtpd.nix
    ../../nixos/restic.nix
    ../../nixos/systemd-boot.nix

    ./hardware-configuration.nix
  ];

  users.users.manolis.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7wZQ2vg+fcPbKMP8B6q1rIpwplVnsK6QiinxnXfEr5"
  ];

  services.fwupd.enable = lib.mkForce false;

  networking = {
    hostName = "mika";
    firewall.enable = false;
  };

  systemd.network.enable = true;
  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp1s0"; # either ens3 (amd64) or enp1s0 (arm64)
    networkConfig.DHCP = "ipv4";
    address = [
      # replace this address with the one assigned to your instance
      "2a01:4f8:c2c:48cb::1/64"
    ];
    routes = [
      {Gateway = "fe80::1";}
    ];
  };

  environment.etc.mailname = {
    text = "mika.netriin.net";
    mode = "0644";
  };

  services.restic.backups.periodic.paths = [
    "/data"
  ];

  services.logrotate.settings = {
    # global options
    header = {
      dateext = true;
    };

    # dockerized traefik access.log
    "/data/services/traefik/logs/access.log" = {
      frequency = "daily";
      rotate = 7;
      compress = true;
      postrotate = ''
        /run/current-system/sw/bin/docker kill --signal=USR1 traefik
      '';
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
