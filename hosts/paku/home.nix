{lib, ...}: {
  imports = [
    ../../home/aris.nix
    ../../home/core
    ../../home/desktop/aris.nix
  ];

  programs.keychain.enable = lib.mkForce false;
}
