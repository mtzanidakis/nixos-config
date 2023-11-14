{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      directory = {
        truncate_to_repo = false;
        truncation_symbol = "…";
      };

      kubernetes = {
        disabled = false;
      };
    };
  };
}
