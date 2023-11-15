{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      directory = {
        truncate_to_repo = false;
        truncation_symbol = "…";
      };

      gcloud = {
        disabled = true;
      };

      kubernetes = {
        disabled = false;
        format = "[$symbol$context(/$namespace)]($style) in ";
      };
    };
  };
}
