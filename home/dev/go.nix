{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
  };

  home.packages = with pkgs; [
    delve
    gdlv
    gofumpt
    golangci-lint
    gopls
    gotools
  ];
}
