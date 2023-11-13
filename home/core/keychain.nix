{ config, pkgs, ... }:

{
  programs.keychain = {
    enable = true;
    agents = [
      "ssh"
    ];
    keys = [
      "github_ed25519"
      "id_ed25519"
      "id_rsa"
    ];
    extraFlags = [
      "--quiet"
      "--timeout 120"
    ];
  };
}
