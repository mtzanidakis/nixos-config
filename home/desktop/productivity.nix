{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-desktop
    calibre
    cointop
    fastfetch
    foliate
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
