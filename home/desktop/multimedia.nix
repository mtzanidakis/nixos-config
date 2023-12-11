{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    audacity
    curtail
    darktable
    ffmpeg
    gimp
    handbrake
    imagemagick
    kdenlive
    jellyfin-media-player
    mousai
    obs-studio
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
