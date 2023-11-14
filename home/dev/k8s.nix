{ config, pkgs, ... }:

{
  imports = [
    ./k9s.nix
  ];

  home.packages = with pkgs; [
    google-cloud-sdk
    helmfile
    kubectl
    kubectx
    kubernetes-helm
  ];
}
