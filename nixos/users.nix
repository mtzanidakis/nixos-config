{ config, pkgs, ... }:

{
  users = {
    groups = {
      manolis = {
        gid = 1000;
      };
    };

    users = {
      manolis = {
        isNormalUser = true;
        uid = 1000;
        group = "manolis";
        extraGroups = [ "wheel" ];
        createHome = true;
        home = "/home/manolis";
        initialPassword = "password";
        shell = pkgs.zsh;
      };
    };
  };
}
