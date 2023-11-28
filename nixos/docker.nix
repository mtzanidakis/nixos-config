{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    liveRestore = false;
    storageDriver = "btrfs";
  };

  users.users.manolis.extraGroups = [ "docker" ];
}
