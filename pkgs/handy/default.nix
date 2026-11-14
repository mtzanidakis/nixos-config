# handy pinned to the current upstream release, unpatched.
#
# Since 0.10.1 handy's Linux default is "Shift+Insert": it puts the transcript on
# the clipboard and the primary selection and sends only the chord, so greek
# survives on our us,gr layout whichever xkb group is active. That replaced our
# own xdg-desktop-portal typing patch (upstream wants to deprecate direct typing,
# so the patch had no future there).
#
# The chord still needs a sender on kwin: wtype is skipped on kde, and enigo's
# XTest fallback lands in Xwayland only. dotool goes through /dev/uinput, which
# nixos/handy.nix opens to the seat user. It sends keycodes, but shift and
# insert sit on the same keys in every group.
#
# nixpkgs lags the upstream release, so the source is pinned here.
{
  handy,
  dotool,
  fetchFromGitHub,
  lib,
  rustPlatform,
}:
handy.overrideAttrs (finalAttrs: prevAttrs: {
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "cjpais";
    repo = "Handy";
    rev = "v${finalAttrs.version}";
    hash = "sha256-vIBZ5FcIvQT5YXkR/63QCSUJbWWBdW8TPP6+OMuejKg=";
  };

  # buildRustPackage reads cargoHash before the fixed point, so overriding it
  # does nothing -- the vendor tree has to be rebuilt by hand.
  cargoDeps = rustPlatform.fetchCargoVendor {
    name = "handy-${finalAttrs.version}-vendor";
    inherit (finalAttrs) src;
    cargoRoot = "src-tauri";
    hash = "sha256-xiT82ODb3F78fiAVBdkSfVKC2Ulvi+T5MUs1LcjjAF8=";
  };

  # Replaces the nixpkgs preFixup rather than extending it, to lose its
  # WEBKIT_DISABLE_DMABUF_RENDERER=1. Since 0.10.0 (src/webkit_renderer.rs) handy
  # picks the renderer from the linked WebKitGTK version, and any value set here
  # skips that. On 2.54 and later the variable leaves the overlay half painted.
  # HANDY_DISABLE_UPDATER stays even though 0.10.1 turns the updater off for
  # builds that cannot install updates: the nixpkgs build goes through a deb
  # bundle, so the binary is stamped "deb" and only the missing dpkg keeps it off.
  preFixup = ''
    gappsWrapperArgs+=(
      --set ALSA_PLUGIN_DIR "${finalAttrs.passthru.alsaPluginDirectory}"
      --set HANDY_DISABLE_UPDATER 1
      --prefix PATH : "${lib.makeBinPath [dotool]}"
    )
  '';

  # frontendDeps picks up the new src through the fixed point, but its own hash
  # is pinned to the nixpkgs release. It moves when bun.lock does, so re-check it
  # on every bump, and also when nixpkgs bumps bun: the installed node_modules
  # differs between bun releases (1.4.2 -> 1.4.4 changed it with the same lock).
  passthru =
    prevAttrs.passthru
    // {
      frontendDeps = prevAttrs.passthru.frontendDeps.overrideAttrs (_: {
        inherit (finalAttrs) src version;
        outputHash = "sha256-2RCuoJpQeg3JN4JqlKvzO4KMz6n7rNXnsb9IyWt9law=";
      });
    };
})
