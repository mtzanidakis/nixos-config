{pkgs, ...}: {
  imports = [
    ./localization.nix
    ./users.nix
    ./vim.nix
  ];

  nix = {
    # weekly gc
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    settings = {
      # optimize store (run manually with `nix-store --optimise`)
      auto-optimise-store = true;

      # enable flakes
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

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
      efibootmgr
      ethtool
      file
      git
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
      usbutils
    ];

    # add zsh completion for system packages
    pathsToLink = ["/share/zsh"];

    # add ~/bin to PATH
    homeBinInPath = true;
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
