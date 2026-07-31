{
  lib,
  pkgs,
  ...
}: {
  # handy ships its own ggml libs under $out/lib, with the same filenames as the
  # whisper-cpp in home/dev/ai.nix -- which collides in the profile's buildEnv.
  # both binaries find their own copies through rpath, so the symlinks in the
  # profile are dead weight either way; let whisper-cpp keep them.
  home.packages = [
    (lib.lowPrio pkgs.handy)
  ];

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
      ExecStart = "${pkgs.handy}/bin/handy --start-hidden";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
