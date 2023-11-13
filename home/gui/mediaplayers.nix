{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jellyfin-media-player
    mpv
    vlc
  ];
}
