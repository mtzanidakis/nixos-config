{
  lib,
  pkgs,
  ...
}: let
  # The `t3` CLI (for `t3 pair` and friends). The package's own desktop
  # launcher is swapped for `desktop` below; its .desktop entry runs
  # `t3code-desktop` from PATH, so it picks that up.
  t3 = pkgs.symlinkJoin {
    name = "t3-${pkgs.t3code.version}";
    paths = [pkgs.t3code];
    postBuild = ''
      rm $out/bin/t3code-desktop $out/bin/.t3code-desktop-wrapped
    '';
  };

  # The desktop app as a client of the server below, showing the same threads
  # as the web UI. By default it starts its own backend on ~/.t3, which the
  # server holds. So it gets its own state dir, seeded with the local
  # environment off (the app then starts no backend at all), and the server is
  # added in the app as a saved environment with a code from `t3 pair`. The
  # settings file is only seeded, since the app rewrites it (window bounds etc.).
  desktop = pkgs.writeShellScriptBin "t3code-desktop" ''
    export T3CODE_HOME="''${T3CODE_HOME:-$HOME/.t3-desktop}"
    settings=$T3CODE_HOME/userdata/desktop-settings.json
    if [ ! -e "$settings" ]; then
      mkdir -p "''${settings%/*}"
      echo '{"localEnvironmentEnabled": false}' > "$settings"
    fi
    exec ${pkgs.t3code}/bin/t3code-desktop "$@"
  '';
in {
  home.packages = [t3 desktop];

  # Git over SSH (pull/push from the UI) needs keychain's agent, whose socket
  # name is random per agent start and only known to shells. Each shell that
  # has it points a fixed path at it, and the service uses that path; it is
  # resolved at connect time, so a later agent restart is picked up by the
  # next shell. Only keychain's own socket, not a forwarded one that dies with
  # its ssh session.
  programs.zsh.initContent = lib.mkAfter ''
    [[ $SSH_AUTH_SOCK == $HOME/.keychain/* && -S $SSH_AUTH_SOCK ]] &&
      ln -sfn "$SSH_AUTH_SOCK" "$XDG_RUNTIME_DIR/keychain-ssh-agent.sock"
  '';

  # Our own unit rather than `t3 service install`, which downloads releases
  # into ~/.t3 and writes a unit pointing at them. Nix owns the version: update
  # with `nix flake update`, not `t3 update` or the in-app updater.
  #
  # Agent CLIs are not pinned into the package; the server reads PATH (and
  # mise's state) from the login shell, so it sees whatever the shell does.
  # Provider instances, including the second Claude on ~/.claude-work, live in
  # ~/.t3/userdata/settings.json, which the server rewrites, so they are set up
  # in the UI.
  systemd.user.services.t3code = {
    Unit.Description = "T3 Code server";

    Service = {
      ExecStart = "${pkgs.t3code}/bin/t3 serve";
      WorkingDirectory = "%h";
      Environment = [
        # Loopback only; nixos/t3code.nix publishes it on the tailnet over
        # HTTPS with Tailscale Serve.
        "T3CODE_HOST=127.0.0.1"
        # Fixed, so clients' saved routes keep working; otherwise it takes the
        # next free port when 3773 is busy.
        "T3CODE_PORT=3773"
        "T3CODE_TELEMETRY_ENABLED=false"
        "SSH_AUTH_SOCK=%t/keychain-ssh-agent.sock"
      ];
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = ["default.target"];
  };
}
