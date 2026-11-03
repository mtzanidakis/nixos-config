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
# Reaching chromium and electron applications needs KWin >= 6.8 (KDE MR !9755).
#
# nixpkgs lags the upstream release, so the source is pinned to the current
# release here rather than applied to the packaged version.
{
  handy,
  fetchFromGitHub,
  rustPlatform,
}:
handy.overrideAttrs (finalAttrs: prevAttrs: {
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "cjpais";
    repo = "Handy";
    rev = "v${finalAttrs.version}";
    hash = "sha256-PnL2le8URBs4I3pv9DKh+JLDII20xtDkJEUJghLToXQ=";
  };

  patches = (prevAttrs.patches or []) ++ [./portal-typing.patch];

  # buildRustPackage reads cargoHash before the fixed point, so overriding it
  # does nothing -- the vendor tree has to be rebuilt by hand. It needs the
  # patch applied too: the lockfile gains ashpd.
  cargoDeps = rustPlatform.fetchCargoVendor {
    name = "handy-${finalAttrs.version}-vendor";
    inherit (finalAttrs) src patches;
    cargoRoot = "src-tauri";
    hash = "sha256-jK+4a1HBZ0nwjzXG+9ckPKoV/Nd7kPcQ5hU3BvrfpWc=";
  };

  # Replaces the nixpkgs preFixup rather than extending it, to lose its
  # WEBKIT_DISABLE_DMABUF_RENDERER=1. Since 0.10.0 (src/webkit_renderer.rs) handy
  # picks the renderer from the linked WebKitGTK version, and any value set here
  # skips that. On 2.54 and later the variable leaves the overlay half painted.
  preFixup = ''
    gappsWrapperArgs+=(
      --set ALSA_PLUGIN_DIR "${finalAttrs.passthru.alsaPluginDirectory}"
      --set HANDY_DISABLE_UPDATER 1
    )
  '';

  # frontendDeps picks up the new src through the fixed point, but its own hash
  # is pinned to the nixpkgs release. It only moves when bun.lock does, so
  # re-check it on every bump.
  passthru =
    prevAttrs.passthru
    // {
      frontendDeps = prevAttrs.passthru.frontendDeps.overrideAttrs (_: {
        inherit (finalAttrs) src version;
        outputHash = "sha256-A45dZkqXl5HOZXvUIazSF956SAhhFSMdYFukmS21MX0=";
      });
    };
})
