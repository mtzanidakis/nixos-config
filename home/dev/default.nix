{ config, pkgs, ... }:

{
  imports = [
    ./db.nix
    ./direnv.nix
    ./docker.nix
    ./go.nix
    ./k8s.nix
    ./neovim.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    ddosify
    fx
    gh
    glow
    go-task
    graphviz
    insomnia
    mkcert
    nfpm
    nssTools
    #postman
    speedtest-go
    testssl
    upx
  ];
}
