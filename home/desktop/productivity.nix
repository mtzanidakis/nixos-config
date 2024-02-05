{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    calibre
    hunspell
    libreoffice-qt
    pdfcpu
    trezor-suite
  ];
}
