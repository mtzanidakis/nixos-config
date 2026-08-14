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
# Only gizu needs this (it is the host running handy); drop the import once the
# fix is upstream in Plasma.
{
  nixpkgs.overlays = [
    (_: prev: {
      kdePackages = prev.kdePackages.overrideScope (_: kprev: {
        kwin = kprev.kwin.overrideAttrs (prevAttrs: {
          patches =
            (prevAttrs.patches or [])
            ++ [../pkgs/kwin/scratch-keymap-keycode.patch];
        });
      });
    })
  ];
}
