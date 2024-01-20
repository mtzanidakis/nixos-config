{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mergerfs
  ];
}
