{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/core
    ../../home/desktop
    ../../home/dev
  ];
}
