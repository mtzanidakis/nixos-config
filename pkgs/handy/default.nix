# handy with an xdg-desktop-portal typing backend.
#
# Every typing backend handy ships resolves a character to a keycode, so on our
# us,gr layout a greek transcript arrives as latin gibberish unless the greek
# group happens to be active. The patch adds a backend that goes through the
# RemoteDesktop portal's NotifyKeyboardKeysym instead, which leaves the symbol
# lookup to kwin.
#
# The patch is content-identical to the branch prepared for upstream,
# feat/portal-typing-main in ~/src/handy-portal-main -- same eight files, same
# added lines, only the hunk offsets differ. It applies to current main as
# cleanly as it does here, so it no longer waits on cjpais/Handy#689 (which is
# keycode-based, stalled, and has the same blind spot). Keep the two in step:
# whatever goes upstream lands here first.
#
# For that to reach chromium and electron applications kwin needs patching too --
# see nixos/kwin-scratch-keymap.nix.
#
# nixpkgs is still on 0.9.1, so the source is pinned to the current release here
# rather than applied to the packaged version.
{
  handy,
  fetchFromGitHub,
  rustPlatform,
}:
handy.overrideAttrs (finalAttrs: prevAttrs: {
  version = "0.9.6";

  src = fetchFromGitHub {
    owner = "cjpais";
    repo = "Handy";
    rev = "v${finalAttrs.version}";
    hash = "sha256-6eNa9iNjwKgLL8t72GeMHTxjyHaeVl+9VF/QWjlHzts=";
  };

  patches = (prevAttrs.patches or []) ++ [./portal-typing.patch];

  # buildRustPackage reads cargoHash before the fixed point, so overriding it
  # does nothing -- the vendor tree has to be rebuilt by hand. It needs the
  # patch applied too: the lockfile gains ashpd.
  cargoDeps = rustPlatform.fetchCargoVendor {
    name = "handy-${finalAttrs.version}-vendor";
    inherit (finalAttrs) src patches;
    cargoRoot = "src-tauri";
    hash = "sha256-VmFrChECctwy4KAs0lMrqWu0rYEFrmod59UiakAU71I=";
  };

  # frontendDeps picks up the new src through the fixed point, but its own hash
  # is pinned to the 0.9.1 bun.lock.
  passthru =
    prevAttrs.passthru
    // {
      frontendDeps = prevAttrs.passthru.frontendDeps.overrideAttrs (_: {
        inherit (finalAttrs) src version;
        outputHash = "sha256-huOC2smHU0sGIxeyvWmzdewUEpKHfdSGNhf9xWpH9Jk=";
      });
    };
})
