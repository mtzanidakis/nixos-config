{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    calibre
    fastfetch
    gnome-frog
    hunspell
    libreoffice-qt
    obsidian
    pdfcpu
    tradingview
    trezor-suite
  ];
}
