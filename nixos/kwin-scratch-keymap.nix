# KWin, patched so that text typed through the xdg-desktop-portal RemoteDesktop
# API also arrives in Chromium and Electron applications.
#
# A keysym the active xkb layout group cannot produce is delivered on a
# throwaway keycode with a one-key scratch keymap, and KWin picks 247 for it.
# Chromium translates evdev codes to DomCode through a fixed table, 247 is not
# in it, and WaylandKeyboard::DispatchKey returns early on DomCode::NONE -- so
# Chrome, VS Code and Slack drop the key without a trace while konsole and KDE
# dialogs type it fine. The patch moves that keycode to KEY_F24, which Chromium
# does know. See pkgs/kwin/scratch-keymap-keycode.patch for the full write-up.
#
# Upstreamed as https://invent.kde.org/plasma/kwin/-/merge_requests/9755, merged
# into master on 2026-08-28 with milestone 6.8 (public release 2026-10-14).
# There is no backport to Plasma/6.7, so the patch is still needed for as long
# as nixpkgs ships 6.7.x -- the 6.7 line runs to 6.7.7 (2027-01-19) without it.
# The guard below trips at 6.7.90, the first 6.8 beta and so the first tag that
# carries the fix; when it does, drop this module, its import in
# hosts/gizu/configuration.nix and the pkgs/kwin directory.
#
# Only gizu needs this -- it is the host running handy.
{lib, ...}: {
  nixpkgs.overlays = [
    (_: prev: {
      kdePackages = prev.kdePackages.overrideScope (_: kprev: {
        kwin = kprev.kwin.overrideAttrs (
          prevAttrs:
            lib.throwIf (lib.versionAtLeast prevAttrs.version "6.7.90") ''
              nixos/kwin-scratch-keymap.nix: kwin ${prevAttrs.version} already carries
              KDE MR !9755. Drop this module, its import in hosts/gizu/configuration.nix
              and the pkgs/kwin directory.
            '' {
              patches =
                (prevAttrs.patches or [])
                ++ [../pkgs/kwin/scratch-keymap-keycode.patch];
            }
        );
      });
    })
  ];
}
