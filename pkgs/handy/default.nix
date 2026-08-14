# handy with an xdg-desktop-portal typing backend.
#
# Every typing backend handy ships resolves a character to a keycode, so on our
# us,gr layout a greek transcript arrives as latin gibberish unless the greek
# group happens to be active. The patch adds a backend that goes through the
# RemoteDesktop portal's NotifyKeyboardKeysym instead, which leaves the symbol
# lookup to kwin. Upstream equivalent is cjpais/Handy#689, which is keycode-based
# and so has the same blind spot; the patch belongs there eventually.
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
  version = "0.9.5";

  src = fetchFromGitHub {
    owner = "cjpais";
    repo = "Handy";
    rev = "v${finalAttrs.version}";
    hash = "sha256-CYSvo03b7d8CeLtvSdO9cyGSdrlpDupKGHITr7E7LuI=";
  };

  patches = (prevAttrs.patches or []) ++ [./portal-typing.patch];

  # buildRustPackage reads cargoHash before the fixed point, so overriding it
  # does nothing -- the vendor tree has to be rebuilt by hand. It needs the
  # patch applied too: the lockfile gains ashpd.
  cargoDeps = rustPlatform.fetchCargoVendor {
    name = "handy-${finalAttrs.version}-vendor";
    inherit (finalAttrs) src patches;
    cargoRoot = "src-tauri";
    hash = "sha256-X/VHX7iW+EhnOh0jL7pfnPvw0oJk5RU/5SpR6xC4oeQ=";
  };

  # frontendDeps picks up the new src through the fixed point, but its own hash
  # is pinned to the 0.9.1 bun.lock.
  passthru =
    prevAttrs.passthru
    // {
      frontendDeps = prevAttrs.passthru.frontendDeps.overrideAttrs (_: {
        inherit (finalAttrs) src version;
        outputHash = "sha256-bkBgSjXPPLCG2ex67jP/euEX/i4IDaK38g6YkXDDAW0=";
      });
    };
})
