#!/bin/sh
set -e
pushd ~/src/nixos-config
sudo nixos-rebuild switch --flake .#
popd
