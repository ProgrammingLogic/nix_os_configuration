#!/run/current-system/sw/bin/bash

NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake ".#jstiverson-workstation"