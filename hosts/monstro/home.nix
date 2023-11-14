{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/core/keychain.nix
    ../../home/core/neovim.nix
    ../../home/gui
    ../../home/gui/graphics.nix
    ../../home/gui/internet.nix
    ../../home/gui/productivity.nix
    ../../home/gui/videoediting.nix
  ];
}
