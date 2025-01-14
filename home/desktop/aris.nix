{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./games.nix
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    audacity
    bitwarden
    fastfetch
    ffmpeg
    firefox
    gimp
    google-chrome
    hunspell
    inkscape
    libreoffice-qt
    jellyfin-media-player
    vlc
    wl-clipboard
    xwaylandvideobridge
  ];
}
