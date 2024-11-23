{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      rocmPackages.clr.icd
      rocmPackages.rocm-runtime
      vaapiVdpau
    ];
  };

  environment.systemPackages = with pkgs; [
    amdgpu_top
    clinfo
    lact
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
  ];
}
