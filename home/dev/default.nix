{pkgs, ...}: {
  imports = [
    ./db.nix
    ./direnv.nix
    ./docker.nix
    ./go.nix
    ./k8s.nix
    ./neovim.nix
    ./php.nix
    ./virt-manager.nix
    ./vscode.nix
    ./zed-editor.nix
  ];

  home.packages = with pkgs; [
    backblaze-b2
    ddosify
    fx
    gh
    glow
    go-task
    graphviz
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
