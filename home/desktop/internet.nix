{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    filezilla
    firefox
    google-chrome
    monolith
    nextcloud-client
    nicotine-plus
    ntfy-sh
    shoutrrr
    signal-desktop
    slack
    telegram-desktop
    transmission_3-qt
    yt-dlp
  ];
}
