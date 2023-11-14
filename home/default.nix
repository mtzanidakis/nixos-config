{ config, pkgs, ... }:

{
  home.username = "manolis";
  home.homeDirectory = "/home/manolis";

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  imports = [
    ./core/direnv.nix
    ./core/fzf.nix
    ./core/git.nix
    ./core/tmux.nix
    ./core/zsh.nix
  ];

  home.packages = with pkgs; [
    bat
    dnsutils
    fortune
    htop
    ncdu
    neofetch
    nmap
    pwgen
    ripgrep
  ];

}
