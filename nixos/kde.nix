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

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs.libsForQt5; [
    kcalc
    kdeconnect-kde
    krecorder
    sddm-kcm
  ];

  # skip default packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
  ];
}
