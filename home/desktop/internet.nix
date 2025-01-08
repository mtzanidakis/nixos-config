{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    filezilla
    firefox
    google-chrome
    monolith
    nextcloud-client
    nicotine-plus
    read-it-later
    signal-desktop
    slack
    transmission_3-qt
    yt-dlp
    #zoom-us
    (zoom-us.overrideAttrs {
     version = "6.2.11.5069";
     src = pkgs.fetchurl {
       url = "https://zoom.us/client/6.2.11.5069/zoom_x86_64.pkg.tar.xz";
       hash = "sha256-k8T/lmfgAFxW1nwEyh61lagrlHP5geT2tA7e5j61+qw=";
       };
     })
  ];
}
