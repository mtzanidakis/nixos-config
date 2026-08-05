{pkgs, ...}: {
  home.packages = with pkgs; [
    (whisper-cpp.override {vulkanSupport = true;})
  ];
}
