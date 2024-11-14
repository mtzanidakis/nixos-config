{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      lact
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
