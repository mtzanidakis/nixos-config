{ config, pkgs, ... }:

{
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    cups-brother-hl1210w
  ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
