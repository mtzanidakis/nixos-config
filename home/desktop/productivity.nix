{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    hunspell
    libreoffice-qt
  ];
}
