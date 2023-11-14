{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    libreoffice-qt
    hunspell
    nextcloud-client
    slack
    zoom-us
  ];
}
