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
    transmission_3-qt
    yt-dlp
  ];
}
