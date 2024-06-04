{ lib, config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/core
  ];

  programs.keychain.enable = lib.mkForce false;
}
