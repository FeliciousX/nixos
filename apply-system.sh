#!/bin/sh
pushd ~/.dotfiles
echo "sudo nixos-rebuild switch --flake .#"
sudo nixos-rebuild switch --flake .#
popd
