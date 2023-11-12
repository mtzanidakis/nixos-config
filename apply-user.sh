#!/bin/sh
pushd ~/src/nixos-config
home-manager switch -f ./users/manolis-$(hostname -s)/home.nix
popd
