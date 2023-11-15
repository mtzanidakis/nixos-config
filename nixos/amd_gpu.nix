{ config, pkgs, ... }:

{
  hardware.opengl.extraPackages = with pkgs; [
    libvdpau-va-gl
    rocm-opencl-icd
    rocm-opencl-runtime
    vaapiVdpau
  ];
}
