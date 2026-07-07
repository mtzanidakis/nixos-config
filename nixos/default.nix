{pkgs, ...}: {
  imports = [
    ./localization.nix
    ./users.nix
    ./vim.nix
  ];

  # Pin catppuccin's system-level enrollment explicitly. Pre-27.05 the module
  # force-enables auto-enroll when autoEnable is unset and warns about it; set
  # both to keep current behavior (all ports themed) and silence the warning.
  catppuccin = {
    enable = true;
    autoEnable = true;
  };

  nix = {
    settings = {
      # optimize store (run manually with `nix-store --optimise`)
      auto-optimise-store = true;

      # enable flakes
      experimental-features = ["nix-command" "flakes"];

      # catppuccin binary cache (pre-built ports & whiskers)
      extra-substituters = ["https://catppuccin.cachix.org"];
      extra-trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };

  # use lts kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # bitwarden-desktop still pins EOL electron 39
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  # timezone
  time.timeZone = "Europe/Athens";

  # default packages
  environment = {
    systemPackages = with pkgs; [
      bc
      cifs-utils
      linuxPackages_latest.cpupower
      comma
      curl
      e2fsprogs
      efibootmgr
      ethtool
      file
      git
      git-filter-repo
      gnumake
      lesspipe
      lsof
      moreutils
      nettools
      nvme-cli
      openssl
      pciutils
      smartmontools
      somo
      testssl
      usbutils
    ];

    # add zsh completion for system packages
    pathsToLink = ["/share/zsh"];

    # add ~/bin to PATH
    homeBinInPath = true;

    # add ~/.local/bin to PATH
    localBinInPath = true;
  };

  # add nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/manolis/src/nixos-config";
  };

  # enable zsh
  programs.zsh.enable = true;

  # add lesspipe support for less
  programs.less = {
    enable = true;
    lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
  };

  services = {
    envfs = {
      enable = true;
    };

    fwupd = {
      enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

    tailscale = {
      enable = true;

      extraUpFlags = [
        "--ssh"
      ];
    };
  };
}
