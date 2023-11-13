{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  zramSwap.enable = true;

  time.timeZone = "Europe/Athens";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

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

  programs.zsh.enable = true;

  services = {
    openssh = {
      enable = true;
    };

    tailscale = {
      enable = true;
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
