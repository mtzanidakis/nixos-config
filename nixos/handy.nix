{pkgs, ...}: {
  # handy types the transcription into the focused window with a virtual
  # keyboard. under kwin wtype is a no-op (no zwp_virtual_keyboard_manager_v1)
  # and kwtype isn't packaged, so handy's auto-detection lands on dotool, which
  # needs write access to /dev/uinput.
  #
  # dotool pushes raw keycodes that kwin reads with whatever xkb group is
  # active, so it can't type greek with our us,gr layout -- handy's paste method
  # is set to ctrl+v, which goes through the clipboard and is layout agnostic.
  # dotool still sends that keystroke.
  hardware.uinput.enable = true;

  users.users.manolis.extraGroups = ["uinput"];

  environment.systemPackages = with pkgs; [
    dotool
  ];
}
