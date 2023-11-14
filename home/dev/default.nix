{ config, pkgs, ... }:

{
  imports = [
    ./db.nix
    ./direnv.nix
    ./neovim.nix
  ];
}
