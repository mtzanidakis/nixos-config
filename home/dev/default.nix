{pkgs, ...}: {
  imports = [
    ./ai.nix
    ./db.nix
    ./direnv.nix
    ./docker.nix
    ./go.nix
    ./js.nix
    ./k8s.nix
    ./neovim.nix
    ./php.nix
    ./virt-manager.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    backblaze-b2
    ddosify
    dos2unix
    fx
    gcc
    gh
    glab
    glow
    go-task
    graphviz
    grype
    httpie
    hyperfine
    jd-diff-patch
    just
    mkcert
    nfpm
    nssTools
    scc
    speedtest-go
    testssl
    upx
    yq
  ];
}
