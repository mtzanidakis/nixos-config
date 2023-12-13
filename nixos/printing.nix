{ config, pkgs, ... }:

{
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      #drivers = with pkgs; [
        #cups-brother-hl1210w
      #];
      #logLevel = "debug";
      drivers = [
        (pkgs.callPackage ./cups-brother-hl1210w.nix {})
      ];
    };
  };
}
