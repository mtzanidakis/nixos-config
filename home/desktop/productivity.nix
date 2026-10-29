{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-desktop
    calibre
    cointop
    fastfetch
    foliate
    hunspell
    libreoffice-qt
    obsidian
    pdfcpu
    ticker
    trezor-suite
  ];
}
