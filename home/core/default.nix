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

  home.packages = with pkgs; [
    bat
    dnsutils
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
    pwgen
    rclone
    restic
    ripgrep
    sshfs
    unzip
    unrar
    zip
    zstd
  ];
}
