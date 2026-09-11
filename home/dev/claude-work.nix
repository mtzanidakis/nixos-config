{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # A second Claude Code with its own config dir, so the work account's auth,
  # settings and history stay apart from `~/.claude`.
  home.packages = [
    (pkgs.writeShellScriptBin "claude-work" ''
      export CLAUDE_CONFIG_DIR="$HOME/.claude-work"
      exec ${pkgs.claude-code}/bin/claude "$@"
    '')
  ];

  # Same pinned skills as `~/.claude`; see ai.nix.
  home.file =
    lib.mapAttrs' (name: source: lib.nameValuePair ".claude-work/skills/${name}" {inherit source;})
    (import ./claude-skills.nix inputs);
}
