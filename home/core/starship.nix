{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      directory = {
        truncate_to_repo = false;
        truncation_symbol = "…";
      };

      hostname = {
        ssh_only = false;
      };

      kubernetes = {
        disabled = false;
      };

      username = {
        show_always = true;
      };
    };
  };
}
