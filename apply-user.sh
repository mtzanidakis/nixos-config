#!/bin/sh
pushd ~/src/nixos-config
home-manager switch -f ./users/manolis/home.nix
popd
