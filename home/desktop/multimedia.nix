{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    audacity
    blender
    curtail
    darktable
    ffmpeg
    gimp
    handbrake
    imagemagick
    kdenlive
    jellyfin-media-player
    mousai
    mpv
    obs-studio
    vhs
    vlc
  ];
}
