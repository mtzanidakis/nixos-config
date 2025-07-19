{pkgs, ...}: {
  home.packages = with pkgs; [
    claude-code
    fabric-ai
    gemini-cli
    warp-terminal
  ];
}
