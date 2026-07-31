{pkgs, ...}: {
  # handy patched to type through the xdg-desktop-portal RemoteDesktop API --
  # see pkgs/handy. That replaces dotool, which pushed raw keycodes through
  # uinput and could only ever type what the active xkb group could reach, so
  # neither hardware.uinput nor the uinput group is needed any more.
  #
  # Requires `Typing Tool: portal` in handy's settings; the portal asks for
  # consent once and the restore token keeps later launches silent.
  environment.systemPackages = [
    (pkgs.callPackage ../pkgs/handy {})
  ];
}
