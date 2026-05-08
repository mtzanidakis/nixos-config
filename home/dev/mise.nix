{pkgs, lib, ...}: {
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
}
