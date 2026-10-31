{config, ...}: let
  tailscale = "${config.services.tailscale.package}/bin/tailscale";
  # Keep in sync with T3CODE_PORT in home/dev/t3code.nix.
  port = 3773;
in {
  # The T3 Code server itself is a user service, see home/dev/t3code.nix. It
  # listens on loopback only; remote clients (phone, other machines) reach it
  # through Tailscale Serve at https://<host>.<tailnet>.ts.net/, so no firewall
  # port is opened. Pair with `t3 pair --tailscale`: it finds this mapping
  # already answering and only mints the link.
  #
  # The mapping is set here rather than by `t3 serve --tailscale-serve`: the
  # server tries once at startup with no retry and removes it on stop, so after
  # a reboot it would race tailscaled and could come up without HTTPS.
  systemd.services.t3code-tailscale-serve = {
    description = "Publish T3 Code on the tailnet over HTTPS";
    after = ["tailscaled.service"];
    wants = ["tailscaled.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${tailscale} serve --bg --https=443 http://127.0.0.1:${toString port}";
      ExecStop = "${tailscale} serve --https=443 off";
      # tailscaled may still be starting or logging in.
      Restart = "on-failure";
      RestartSec = 10;
    };
  };

  # Start the user manager, and with it the server, at boot rather than at
  # first login, so the machine is reachable remotely right after a reboot.
  users.users.manolis.linger = true;
}
