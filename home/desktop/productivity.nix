{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    calibre
    fastfetch
    hunspell
    libreoffice-qt
    pdfcpu
    tradingview
    trezor-suite
  ];
}
