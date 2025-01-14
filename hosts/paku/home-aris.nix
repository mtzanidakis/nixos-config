{lib, ...}: {
  imports = [
    ../../home
    ../../home/core
    ../../home/desktop/aris.nix
  ];

  home.username = lib.mkForce "aris";
  home.homeDirectory = lib.mkForce "/home/aris";

  programs.keychain.enable = lib.mkForce false;
}
