{pkgs, ...}: {
  programs.dconf.enable = true;

  services = {
    colord.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };
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
      ksshaskpass
      kweather
      mlt
      sddm-kcm
      skanlite
      xwaylandvideobridge
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
