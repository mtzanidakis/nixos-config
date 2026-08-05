{lib, ...}: {
  imports = [
    ../../home
    ../../home/core
    ../../home/dev
  ];

  programs.keychain.enable = lib.mkForce false;
}
