{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-cli
    (bitwarden-desktop.override {
      electron_39 = electron_39-bin;
    })
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
    trezor-suite
  ];
}
