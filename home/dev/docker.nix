{pkgs, ...}: {
  home.packages = with pkgs; [
    diffoci
    dive
    docker-buildx
    docker-compose
    docker-ls
  ];
}
