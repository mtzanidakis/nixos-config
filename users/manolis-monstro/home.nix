{ config, pkgs, ... }:

{
  imports = [
    ../manolis
    ../manolis/core/keychain.nix
    ../manolis/gui
  ];

  home.packages = with pkgs; [
    bitwarden

    jellyfin-media-player
  ];
}
