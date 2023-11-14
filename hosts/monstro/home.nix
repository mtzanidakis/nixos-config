{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/core
    ../../home/dev
    ../../home/gui
    ../../home/gui/graphics.nix
    ../../home/gui/internet.nix
    ../../home/gui/productivity.nix
    ../../home/gui/videoediting.nix
  ];
}
