#!/run/current-system/sw/bin/bash

export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake ".#$(hostname)"