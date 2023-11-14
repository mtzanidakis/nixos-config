{ config, pkgs, ... }:

{
  # enable zram swap
  zramSwap.enable = true;

  # keep last 10 generations
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.kernel.sysctl = {
    "vm.page-cluster" = 0;
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };

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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "el_GR.UTF-8";
      LC_MONETARY = "el_GR.UTF-8";
      LC_ADDRESS = "el_GR.UTF-8";
      LC_TELEPHONE = "el_GR.UTF-8";
      LC_MEASUREMENT = "el_GR.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

  # console font and keyboard layout
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # default packages
  environment = {
    systemPackages = with pkgs; [
      curl
      git
      gnumake
      vim
    ];

    # add zsh completion for system packages
    pathsToLink = [ "/share/zsh" ];

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  # enable zsh
  programs.zsh.enable = true;

  services = {
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

    xserver = {
      layout = "us,gr";
      xkbOptions = "grp:alt_shift_toggle,ctrl:nocaps,grp_led:caps,terminate:ctrl_alt_bksp";
    };
  };

  users = {
    groups = {
      manolis = {
        gid = 1000;
      };
    };

    users = {
      manolis = {
        isNormalUser = true;
        uid = 1000;
        group = "manolis";
        extraGroups = [ "wheel" ];
        createHome = true;
        home = "/home/manolis";
        initialPassword = "password";
        shell = pkgs.zsh;
      };
    };
  };
}
