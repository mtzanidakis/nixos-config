{pkgs, ...}: {
  home.packages = with pkgs; [
    claude-code
    llmfit
    openai-whisper
    opencode
  ];
}
