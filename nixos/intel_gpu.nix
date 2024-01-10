{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
      intel-vaapi-driver
    ];
  };
}
