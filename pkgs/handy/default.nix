# handy with an xdg-desktop-portal typing backend.
#
# Every typing backend handy ships resolves a character to a keycode, so on our
# us,gr layout a greek transcript arrives as latin gibberish unless the greek
# group happens to be active. The patch adds a backend that goes through the
# RemoteDesktop portal's NotifyKeyboardKeysym instead, which leaves the symbol
# lookup to kwin. Upstream equivalent is cjpais/Handy#689, still unreviewed and
# still keycode-based; the patch belongs there eventually.
#
# nixpkgs is on 0.9.1 and the patch is written against upstream main, so the
# source is pinned here rather than applied to the packaged version.
{
  handy,
  fetchFromGitHub,
  rustPlatform,
}:
handy.overrideAttrs (finalAttrs: prevAttrs: {
  version = "0.9.4-unstable-2026-07-31";

  src = fetchFromGitHub {
    owner = "cjpais";
    repo = "Handy";
    rev = "a70ac84fd66819d171a0bce156e4f729aa46527a";
    hash = "sha256-S7IEMXja2MxamM9esNowy0YO29Szy8cF1ManaUeHU50=";
  };

  patches = (prevAttrs.patches or []) ++ [./portal-typing.patch];

  # buildRustPackage reads cargoHash before the fixed point, so overriding it
  # does nothing -- the vendor tree has to be rebuilt by hand. It needs the
  # patch applied too: the lockfile gains ashpd.
  cargoDeps = rustPlatform.fetchCargoVendor {
    name = "handy-${finalAttrs.version}-vendor";
    inherit (finalAttrs) src patches;
    cargoRoot = "src-tauri";
    hash = "sha256-Ku43JdiI2+i5gY+Nz4gAEC4Goro7wMoE+YijhQcFpwI=";
  };

  # frontendDeps picks up the new src through the fixed point, but its own hash
  # is pinned to the 0.9.1 bun.lock.
  passthru =
    prevAttrs.passthru
    // {
      frontendDeps = prevAttrs.passthru.frontendDeps.overrideAttrs (_: {
        inherit (finalAttrs) src version;
        outputHash = "sha256-Yb8lA+BdGfdrMs7xbYxyIkyw1Q+UdK4PVQ6fnIr54o8=";
      });
    };
})
