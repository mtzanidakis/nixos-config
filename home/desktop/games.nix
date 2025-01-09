{pkgs, ...}: {
  home.packages = with pkgs; [
    protonup-qt
    steam-run
  ];
}
