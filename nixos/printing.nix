{ config, pkgs, ... }:

{
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-brother-hl1210w
      ];
    };
  };
}
