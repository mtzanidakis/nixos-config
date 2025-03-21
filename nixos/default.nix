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

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # timezone
  time.timeZone = "Europe/Athens";

  # default packages
  environment = {
    systemPackages = with pkgs; [
      cifs-utils
      linuxPackages_latest.cpupower
      comma
      curl
      efibootmgr
      ethtool
      file
      git
      gnumake
      nvme-cli
      openssl
      pciutils
      smartmontools
      usbutils
    ];

    # add zsh completion for system packages
    pathsToLink = ["/share/zsh"];

    # add ~/bin to PATH
    homeBinInPath = true;
  };

  # enable zsh
  programs.zsh.enable = true;

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
