{pkgs, ...}: {
  home.packages = with pkgs; [
    dbgate
    go-migrate
    mongodb-tools
    mongosh
    #mycli
    pg_activity
    pgcli
    sqlite
  ];
}
