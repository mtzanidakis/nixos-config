{pkgs, ...}: {
  home.packages = with pkgs; [
    antigravity
    claude-code
    codex
    code-cursor-fhs
    cursor-cli
    fabric-ai
    gemini-cli
    lmstudio
    warp-terminal
    openai-whisper
  ];
}
