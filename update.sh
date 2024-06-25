#!/bin/sh
pushd /etc/nixos
echo "nix flake update --commit-lock-file"
nix flake update --commit-lock-file
popd
