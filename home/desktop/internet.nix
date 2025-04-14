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
    signal-desktop-source
    slack
    transmission_3-qt
    yt-dlp
  ];
}
