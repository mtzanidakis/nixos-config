{pkgs, lib, ...}: {
  programs.go = {
    enable = true;
  };

  home.packages = with pkgs; [
    delve
    gdlv
    gofumpt
    golangci-lint
    gopls
    goreleaser
    (lib.lowPrio gotools)
    go-tools
  ];
}
