{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./internet.nix
    ./multimedia.nix
    ./productivity.nix
  ];

  home.packages = with pkgs; [
    xwaylandvideobridge
  ];
}
