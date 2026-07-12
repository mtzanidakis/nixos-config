{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity
    curtail
    darktable
    easyeffects
    feishin
    ffmpeg
    gimp
    glaxnimate
    # handbrake # BROKEN in nixpkgs: HandBrake 1.11.1 pins ffmpeg 8.0.1 but
    # nixpkgs ships ffmpeg_8-full 8.1.2, so its contrib patches fail to apply.
    # Downgrading ffmpeg doesn't work either (8.0.1 won't compile under gcc15 /
    # current svt-av1). Re-enable once nixpkgs realigns the versions upstream.
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
