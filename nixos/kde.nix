{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasma";
    };
    desktopManager = {
      plasma6.enable = true;
    };
  };

  services.colord.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    colord-kde
    kcalc
    kdeconnect-kde
    krecorder
    kweather
    sddm-kcm
    skanlite
  ];

  # skip default packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];
}
