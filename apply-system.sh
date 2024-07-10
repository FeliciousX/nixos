#!/bin/sh
pushd /etc/nixos
echo "sudo nixos-rebuild switch --flake .#$hostname -v --show-trace"
sudo nixos-rebuild switch --flake .#$hostname  -v --show-trace
popd
