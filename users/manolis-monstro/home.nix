{ config, pkgs, ... }:

{
  imports = [
    ../manolis
    ../manolis/core/keychain.nix
  ];

  home.packages = with pkgs; [
    bitwarden

    jetbrains-mono
    jellyfin-media-player
  ];

  programs.alacritty.enable = true;
}
