{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./games.nix
    ./internet.nix
    ./multimedia.nix
    ./productivity.nix
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    ghostty
    wl-clipboard
    xwaylandvideobridge
    xorg.xhost
  ];

  home.file.pw-pa-conf = {
    text = ''
      pulse.properties = {
          server.address = [
              "unix:native"
              "unix:/tmp/pulseaudio.socket"
          ]
      }
    '';

    target = "${config.xdg.configHome}/pipewire/pipewire-pulse.conf.d/socket.conf";
  };
}
