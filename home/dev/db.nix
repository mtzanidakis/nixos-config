{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    go-migrate
    iredis
    mongodb-compass
    mongodb-tools
    mongosh
    mycli
    pgcli
  ];
}
