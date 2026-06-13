{pkgs, lib, config, ...}: let
  # nixpkgs bug (2026-06): mise's bundled `_mise` zsh completion hardcodes the
  # nixpkgs `usage` store path, which is stuck at 3.2.1, while mise 2026.6.0's
  # usage spec requires >= 3.4 -> spurious `[WARN usage::spec]` on `mise <TAB>`.
  # Regenerate `_mise` from the same mise package: that version calls bare
  # `usage` from PATH (the mise-managed 3.5.0), so the warning goes away. We then
  # prepend it to fpath ahead of the broken one (see initContent below).
  miseZshCompletion = pkgs.runCommandLocal "mise-zsh-completion" {} ''
    export HOME=$(mktemp -d)
    ${lib.getExe pkgs.mise} completion zsh > $out
  '';
in {
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".local/share/zsh/site-functions/_mise".source = miseZshCompletion;

  # Put our regenerated `_mise` earlier in fpath than the nixpkgs one. Must run
  # after the NIX_PROFILES fpath setup (order 520) and before oh-my-zsh sources
  # `oh-my-zsh.sh` / runs compinit (order 800).
  programs.zsh.initContent = lib.mkOrder 600 ''
    fpath=(${config.home.homeDirectory}/.local/share/zsh/site-functions $fpath)
  '';
}
