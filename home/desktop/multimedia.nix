{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    audacity
    curtail
    darktable
    ffmpeg
    gimp
    glaxnimate
    handbrake
    imagemagick
    inkscape
    kdenlive
    jellyfin-media-player
    mousai
    obs-studio
    scribus
    tidal-dl
    tidal-hifi
    vhs
    vlc
  ];

  programs.mpv = {
    enable = true;
    config = {
      gpu-context = "wayland";
      hwdec = "auto-safe";
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
      vo = "gpu";
    };
  };
}
