{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    filezilla
    firefox
    nextcloud-client
    signal-desktop
    slack
    transmission-qt
    zoom-us
  ];
}
