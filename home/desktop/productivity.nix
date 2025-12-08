{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-desktop
    calibre
    fastfetch
    gnome-frog
    hunspell
    libreoffice-qt
    obsidian
    pdfcpu
    ticker
    tradingview
    trezor-suite
  ];
}
