{pkgs, ...}: {
  home.packages = with pkgs; [
    claude-code
    gemini-cli
    warp-terminal
  ];
}
