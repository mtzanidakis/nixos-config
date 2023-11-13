{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./mediaplayers.nix
  ];

  home.packages = with pkgs; [
    bitwarden

    jetbrains-mono
    xwaylandvideobridge
    plasma5Packages.plasma-browser-integration
  ];
}
