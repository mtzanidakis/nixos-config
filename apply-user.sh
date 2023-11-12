#!/bin/sh
set -e
pushd ~/src/nixos-config
#nix build .#homeManagerConfigurations.manolis-$(hostname -s).activationPackage
#./result/activate
#rm -f -- result
home-manager switch -f ./users/manolis-$(hostname -s)/home.nix
popd
