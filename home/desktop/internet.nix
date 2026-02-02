{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    filezilla
    firefox
    google-chrome
    monolith
    nextcloud-client
    nicotine-plus
    signal-desktop
    slack
    telegram-desktop
    transmission_4-qt
    yt-dlp
    zoom-us
  ];
}
