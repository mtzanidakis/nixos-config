{pkgs, ...}: {
  programs.dconf.enable = true;

  services = {
    colord.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };

  environment = {
    # extra kde packages
    systemPackages = with pkgs.kdePackages; [
      colord-kde
      kcalc
      kclock
      kdeconnect-kde
      kdenlive
      krecorder
      krdc
      ksshaskpass
      kweather
      mlt
      sddm-kcm
      skanlite
    ] ++ [
      (pkgs.catppuccin-kde.override {
         flavour = ["macchiato"];
         accents = ["sapphire"];
       })
      (pkgs.catppuccin-sddm.override {
         flavor = "macchiato";
         accent = "sapphire";
       })
    ];

    # skip default packages
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
    ];
  };
}
