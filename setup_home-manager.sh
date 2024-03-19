#!/run/current-system/sw/bin/bash

home-manager switch --flake ".#$(whoami)@$(hostname)"