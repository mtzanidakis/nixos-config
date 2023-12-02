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
      localConf = ''
        <alias binding="same">
           <family>Helvetica</family>
           <accept>
           <family>Arial</family>
           </accept>
         </alias>
         <alias binding="same">
           <family>Times</family>
           <accept>
           <family>Times New Roman</family>
           </accept>
         </alias>
         <alias binding="same">
           <family>Courier</family>
           <accept>
           <family>Courier New</family>
           </accept>
         </alias>
      '';
    };
  };
}
