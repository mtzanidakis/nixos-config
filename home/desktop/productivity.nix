{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    calibre
    fastfetch
    hunspell
    libreoffice-qt
    obsidian
    pdfcpu
    tradingview
    trezor-suite
  ];
}
