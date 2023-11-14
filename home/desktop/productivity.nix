{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    calibre
    hunspell
    libreoffice-qt
  ];
}
