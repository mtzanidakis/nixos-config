{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      lact
      libvdpau-va-gl
      rocm-opencl-icd
      rocm-opencl-runtime
      vaapiVdpau
    ];
  };
}
