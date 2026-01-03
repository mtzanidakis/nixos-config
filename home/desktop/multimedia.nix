{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity
    curtail
    darktable
    easyeffects
    ffmpeg
    gimp
    glaxnimate
    handbrake
    imagemagick
    inkscape
    jellyfin-desktop
    mousai
    obs-studio
    picard
    scribus
    tidal-dl
    upscayl
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
