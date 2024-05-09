{ config, lib, pkgs, ... }:

{
  services.restic.backups = {
    periodic = {
      initialize = true;
      environmentFile = "/root/.config/restic/env";
      repositoryFile = "/root/.config/restic/repository";
      passwordFile = "/root/.config/restic/password";

      timerConfig = {
        OnCalendar = "0/4:00";
      };

      exclude = [
        ".git"
        ".gitkeep"
      ];

      paths = [
        "/data/services/*/.env"
        "/data/services/*/config"
        "/data/services/*/data"
        "/data/services/*/docker-compose.override.yml"
        "/data/services/*/dumps"
        "/data/services/*/logs"
        "/data/sites/*/.env"
        "/data/sites/*/config"
        "/data/sites/*/data"
        "/data/sites/*/docker-compose.override.yml"
        "/data/sites/*/dumps"
        "/data/sites/*/logs"
        "/data/sites/*/wp-content"
      ];

      pruneOpts = [
        "--keep-hourly 6"
        "--keep-daily 7"
        "--keep-weekly 2"
        "--keep-monthly 12"
        "--keep-yearly 1"
      ];
    };
  };
}
