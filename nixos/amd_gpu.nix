{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      clinfo
      lact
      libvdpau-va-gl
      rocmPackages.clr.icd
      rocmPackages.rocm-runtime
      rocmPackages.rocminfo
      vaapiVdpau
    ];
  };
}
