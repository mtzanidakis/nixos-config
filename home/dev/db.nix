{pkgs, ...}: {
  home.packages = with pkgs; [
    dbgate
    go-migrate
    mongodb-atlas-cli
    mongodb-tools
    mongosh
    #mycli
    pg_activity
    pgcli
    sqlite
  ];
}
