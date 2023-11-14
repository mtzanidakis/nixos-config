{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    firefox
    nextcloud-client
    signal-desktop
    slack
    transmission-qt
    zoom-us
  ];
}
