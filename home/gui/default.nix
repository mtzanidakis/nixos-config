{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./mediaplayers.nix
  ];

  home.packages = with pkgs; [
    bitwarden
    firefox

    jetbrains-mono
    xwaylandvideobridge
    plasma5Packages.plasma-browser-integration
  ];
}
