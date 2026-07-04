{pkgs, ...}: {
  home.packages = with pkgs; [
    claude-code
    llmfit
    opencode
    opencode-desktop
    (whisper-cpp.override { vulkanSupport = true; })
  ];
}
