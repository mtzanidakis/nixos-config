{ config, pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./fzf.nix 
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    bat
    fortune
    htop
    ncdu
    neofetch
    nmap
    pwgen
    ripgrep
  ];
}
