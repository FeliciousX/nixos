#!/bin/sh
pushd ~/.dotfiles
echo "nix flake update --commit-lock-file"
nix flake update --commit-lock-file
popd
