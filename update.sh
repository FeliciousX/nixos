#!/bin/sh
pushd ~/.dotfiles
nix flake update --commit-lock-file
popd
