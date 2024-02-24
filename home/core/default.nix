{ config, pkgs, ... }:

{
  imports = [
    ./fzf.nix
    ./git.nix
    ./keychain.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs = {
    atuin = {
      enable = true;
    };
    nix-index.enable = true;
    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
  };

  home.packages = with pkgs; [
    bat
    comma
    dnsutils
    dogdns
    dua
    eza
    fortune
    gocryptfs
    htop
    inetutils
    jq
    lm_sensors
    ncdu
    neofetch
    nmap
    nvd
    pwgen
    rclone
    restic
    ripgrep
    sshfs
    tailspin
    unzip
    unrar
    wget
    wol
    zip
    zstd
  ];
}
