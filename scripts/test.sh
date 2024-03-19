#!/run/current-system/sw/bin/bash

cd ../

sudo cp nix/* /etc/nixos/
sudo nixos-rebuild test