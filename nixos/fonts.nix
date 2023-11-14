{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ubuntu_font_family
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
