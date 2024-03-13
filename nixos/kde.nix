{ config, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    colord.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "plasma";
      };
    };
  };

  environment = {
    # extra kde packages
    systemPackages = with pkgs.kdePackages; [
      colord-kde
      kcalc
      kdeconnect-kde
      krecorder
      kweather
      sddm-kcm
      skanlite
    ];

    # skip default packages
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
    ];
  };
}
