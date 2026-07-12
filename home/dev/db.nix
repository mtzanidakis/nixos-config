{pkgs, ...}: {
  home.packages = with pkgs; [
    dbgate
    go-migrate
    # mongodb-compass's nixpkgs derivation calls wrapGAppsHook manually inside
    # buildCommand, which is incompatible with wrapGAppsHook3 (it operates on
    # $prefix/$output, only set during fixupPhase) and fails with
    # "wrapGAppsHookHasRunForOutput: bad array subscript". Set the vars before
    # the call. Remove once fixed upstream in nixpkgs.
    (mongodb-compass.overrideAttrs (old: {
      buildCommand =
        builtins.replaceStrings
        ["wrapGAppsHook $out/bin/mongodb-compass"]
        ["export prefix=$out\n    export output=out\n    wrapGAppsHook"]
        old.buildCommand;
    }))
    mongodb-tools
    mongosh
    #mycli
    pg_activity
    pgcli
    sqlite
  ];
}
