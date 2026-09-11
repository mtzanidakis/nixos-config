{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    claude-code
    llmfit
    opencode
  ];

  # Skills are pinned via flake inputs rather than the `~/.agents` skill
  # installer, so they are identical on every host and move with `nix flake
  # update`. Claude still reads unmanaged entries dropped into `.claude/skills`.
  # Everything else under `~/.claude` (settings, auth, session history) stays
  # mutable -- Claude and herdr both write it.
  home.file =
    lib.mapAttrs' (name: source: lib.nameValuePair ".claude/skills/${name}" {inherit source;})
    (import ./claude-skills.nix inputs);
}
