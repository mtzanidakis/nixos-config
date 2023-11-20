{ config, pkgs, ... }:

{
  imports = [
    ./fzf.nix
    ./git.nix
    ./keychain.nix
    ./starship.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];

  programs.nix-index.enable = true;

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
    nvd
    pwgen
    rclone
    restic
    ripgrep
    sshfs
    tailspin
    unzip
    unrar
    zip
    zstd
  ];
}
