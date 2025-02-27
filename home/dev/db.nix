{pkgs, ...}: {
  home.packages = with pkgs; [
    go-migrate
    iredis
    mongodb-compass
    mongodb-tools
    mongosh
    mycli
    pg_activity
    pgcli
    sqlite
  ];
}
