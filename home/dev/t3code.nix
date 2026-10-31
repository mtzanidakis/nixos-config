{pkgs, ...}: let
  # The desktop app always starts its own backend on ~/.t3 and refuses to run
  # while this server holds it, so only the `t3` CLI goes on PATH (for `t3 pair`
  # and friends). Use the web UI at http://localhost:3773 locally.
  t3 = pkgs.symlinkJoin {
    name = "t3-${pkgs.t3code.version}";
    paths = [pkgs.t3code];
    postBuild = ''
      rm -r $out/bin/t3code-desktop $out/bin/.t3code-desktop-wrapped $out/share/applications
    '';
  };
in {
  home.packages = [t3];

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
      ];
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = ["default.target"];
  };
}
