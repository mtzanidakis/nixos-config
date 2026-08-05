{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  programs.go = {
    enable = true;

    # on zumi keep the go workspace on the /data subvol instead of ~/go
    env.GOPATH = lib.mkIf (osConfig.networking.hostName == "zumi") "/data/go";
  };

  # go install drops binaries in $GOPATH/bin
  home.sessionPath = lib.optionals (osConfig.networking.hostName == "zumi") [
    "/data/go/bin"
  ];

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
