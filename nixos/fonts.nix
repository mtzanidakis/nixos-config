{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      departure-mono
      roboto
      noto-fonts
      noto-fonts-cjk-sans
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
