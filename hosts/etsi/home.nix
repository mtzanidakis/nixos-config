{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/core
  ];

  programs.keychain.enable = false;
}
