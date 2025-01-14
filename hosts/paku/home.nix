{lib, ...}: {
  imports = [
    ../../home
    ../../home/core
    ../../home/desktop/aris.nix
  ];

  programs.keychain.enable = lib.mkForce false;
}
