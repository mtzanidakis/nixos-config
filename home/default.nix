{
  pkgs,
  inputs,
  ...
}: {
  home.username = "manolis";
  home.homeDirectory = "/home/manolis";

  programs.home-manager.enable = true;

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "macchiato";
    accent = "sapphire";

    # Use the whiskers from nixpkgs (cached) instead of building catppuccin's
    # own from source. overrideScope swaps it in the whole package scope so the
    # generated port sources don't pull in the from-source build either.
    # https://github.com/catppuccin/nix/issues/927#issuecomment-4456677608
    sources =
      inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope
      (final: prev: {
        whiskers = pkgs.catppuccin-whiskers;
      });
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
}
