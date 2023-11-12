#!/bin/sh
set -e
pushd ~/src/nixos-config
nix build .#homeManagerConfigurations.manolis-$(hostname -s).activationPackage
./result/activate
rm -f -- result
popd
