{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      corefonts
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      hinting.style = "slight";
    };
  };
}
