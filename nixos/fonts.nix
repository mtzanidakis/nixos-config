{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      departure-mono
      roboto
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      ubuntu_font_family
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      hinting.style = "slight";
    };
  };
}
