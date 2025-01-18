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
    read-it-later
    shoutrrr
    signal-desktop
    slack
    transmission_3-qt
    yt-dlp
  ];
}
