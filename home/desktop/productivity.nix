{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden
    #bitwarden-cli
    buffer
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
