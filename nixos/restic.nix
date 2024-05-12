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
        "/home"
        "/root"
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
