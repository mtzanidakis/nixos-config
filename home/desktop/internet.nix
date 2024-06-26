{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    filezilla
    firefox
    google-chrome
    monolith
    nextcloud-client
    nicotine-plus
    signal-desktop
    slack
    transmission_3-qt
    yt-dlp
    zoom-us
  ];
}
