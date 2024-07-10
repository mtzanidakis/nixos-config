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
      settings = {
        enter_accept = false;
      };
      flags = [
        "--disable-up-arrow"
      ];
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
    btop
    comma
    dnsutils
    dogdns
    dua
    eza
    fastfetch
    fortune
    gocryptfs
    htop
    inetutils
    jnv
    jq
    lm_sensors
    ncdu
    nmap
    nvd
    pwgen
    rclone
    restic
    ripgrep
    sshfs
    tailspin
    tldr
    unzip
    unrar
    wget
    wol
    zip
    zstd
  ];
}
