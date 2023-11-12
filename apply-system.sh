#!/bin/sh
pushd ~/src/nixos-config
sudo nixos-rebuild switch -I nixos-config=./systems/$(hostname -s)/configuration.nix
popd
