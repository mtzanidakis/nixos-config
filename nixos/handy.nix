{pkgs, ...}: let
  # handy patched to type through the xdg-desktop-portal RemoteDesktop API --
  # see pkgs/handy for why. Once that lands upstream this drops back to
  # pkgs.handy.
  handy = pkgs.callPackage ../pkgs/handy {};
in {
  # dotool pushes raw keycodes that kwin reads with whatever xkb group is
  # active, so it can't type greek with our us,gr layout. It stays as the
  # fallback for the moment; with Typing Tool set to `portal` nothing here is
  # needed any more and hardware.uinput plus the group can go.
  hardware.uinput.enable = true;

  users.users.manolis.extraGroups = ["uinput"];

  environment.systemPackages = [
    handy
    pkgs.dotool
  ];
}
