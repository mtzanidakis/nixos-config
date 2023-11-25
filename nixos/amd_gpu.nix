{ config, pkgs, ... }:

{
  hardware.opengl.extraPackages = with pkgs; [
    lact
    libvdpau-va-gl
    rocm-opencl-icd
    rocm-opencl-runtime
    vaapiVdpau
  ];
}
