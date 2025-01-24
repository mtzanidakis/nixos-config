{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
  };

  home.packages = with pkgs; [
    code-cursor
  ];
}
