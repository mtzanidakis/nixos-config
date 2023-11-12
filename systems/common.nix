{ config, pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.manolis = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    curl
    vim
  ];

  programs.zsh.enable = true;

  # add zsh completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  services.openssh.enable = true;
  services.tailscale.enable = true;
}
