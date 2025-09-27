{pkgs, ...}: {
  home.packages = with pkgs; [
    claude-code
    codex
    fabric-ai
    gemini-cli
    warp-terminal
    openai-whisper
  ];
}
