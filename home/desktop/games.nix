{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    protonup-qt
    steam-run
  ];
}
