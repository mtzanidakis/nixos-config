{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ctop
    diffoci
    dive
    docker-buildx
    docker-compose
    docker-ls
  ];
}
