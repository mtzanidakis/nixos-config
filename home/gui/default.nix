{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./mediaplayers.nix
  ];

  home.packages = with pkgs; [
    bitwarden
    xwaylandvideobridge
  ];
}
