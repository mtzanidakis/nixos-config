{ config, pkgs, ... }:

{
  imports = [
    ./db.nix
    ./direnv.nix
    ./docker.nix
    ./neovim.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
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
    upx
  ];
}
