{pkgs, ...}: let
  # Same patched build the system module installs; referenced directly so the
  # unit can never end up pointing at a different handy than the one on PATH.
  handy = pkgs.callPackage ../../pkgs/handy {};
in {
  # The package itself lives in nixos/handy.nix rather than home.packages: it
  # ships ggml libs whose filenames collide with the whisper-cpp in
  # home/dev/whisper-cpp.nix, and the home profile would shadow the system one
  # anyway.

  # handy's own global shortcuts don't reach a wayland session, so the hotkey is
  # a kde custom shortcut running `handy --toggle-transcription`; that needs an
  # instance already running.
  systemd.user.services.handy = {
    Unit = {
      Description = "Handy speech-to-text";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${handy}/bin/handy --start-hidden";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
