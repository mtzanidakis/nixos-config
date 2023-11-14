{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    filezilla
    firefox
    google-chrome
    nextcloud-client
    signal-desktop
    slack
    transmission-qt
    zoom-us
  ];
}
