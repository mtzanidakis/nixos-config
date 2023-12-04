{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd = {
    enabled = true;
  };
}
