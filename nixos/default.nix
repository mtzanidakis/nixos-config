{ config, pkgs, ... }:

{
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
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # timezone
  time.timeZone = "Europe/Athens";

  # default packages
  environment = {
    systemPackages = with pkgs; [
      curl
      ethtool
      git
      gnumake
    ];

    # add zsh completion for system packages
    pathsToLink = [ "/share/zsh" ];
  };

  # enable zsh
  programs.zsh.enable = true;

  services = {
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
