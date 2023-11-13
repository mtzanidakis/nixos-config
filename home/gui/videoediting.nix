{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    blender
    handbrake
    kdenlive
  ];
}
