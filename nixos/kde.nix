{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasmawayland";
    };
    desktopManager = {
      plasma5.enable = true;
    };
  };

  services.colord.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs.libsForQt5; [
    colord-kde
    kcalc
    kdeconnect-kde
    krecorder
    kweather
    sddm-kcm
    skanlite
  ];

  # skip default packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
