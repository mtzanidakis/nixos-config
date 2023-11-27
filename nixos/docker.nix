{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    storageDriver = "btrfs";
  };

  users.users.manolis.extraGroups = [ "docker" ];
}
