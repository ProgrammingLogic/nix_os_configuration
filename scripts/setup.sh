#!/run/current-system/sw/bin/bash

NIX_CONFIG="experimental-features = nix-command flakes"

cd ../
sudo nixos-rebuild switch --flake ".#jstiverson-workstation"