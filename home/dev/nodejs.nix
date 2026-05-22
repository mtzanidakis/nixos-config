{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs_26
  ];
}
