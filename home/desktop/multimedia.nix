{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity
    curtail
    darktable
    feishin
    ffmpeg
    gimp3
    glaxnimate
    handbrake
    imagemagick
    inkscape
    jellyfin-media-player
    mousai
    obs-studio
    picard
    scribus
    tidal-dl
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
