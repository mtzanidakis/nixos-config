{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd = {
    enable = true;
  };
}
