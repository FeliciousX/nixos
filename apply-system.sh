#!/bin/sh
pushd /etc/nixos
echo "sudo nixos-rebuild switch --flake .#$1"
sudo nixos-rebuild switch --flake .#$1
popd
