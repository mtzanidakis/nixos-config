{ config, pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./keychain.nix
    ./neovim.nix
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
    lm_sensors
    ncdu
    neofetch
    nmap
    pwgen
    restic
    ripgrep
    sshfs
    unzip
    unrar
    zip
    zstd
  ];
}
