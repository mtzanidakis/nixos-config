{ config, pkgs, ... }:

{
  imports = [
    ./db.nix
    ./direnv.nix
    ./docker.nix
    ./go.nix
    ./k8s.nix
    ./neovim.nix
    ./virt-manager.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    bruno
    ddosify
    fx
    gh
    glow
    go-task
    graphviz
    mkcert
    nfpm
    nssTools
    scc
    speedtest-go
    testssl
    upx
  ];
}
