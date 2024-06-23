#!/bin/sh
pushd /etc/nixos
echo "sudo nixos-rebuild switch --flake .#$1 -v --show-trace"
sudo nixos-rebuild switch --flake .#$1 -v --show-trace
popd
