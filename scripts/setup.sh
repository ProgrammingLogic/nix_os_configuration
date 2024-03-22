#!/usr/bin/env bash
#
NIX_CONFIG="experimental-features = nix-command flakes"


# List of options
OPTIONS=(
    "jstiverson-desktop"
    "jstiverson-thinkpad"
    "jstiverson-dell_xps_13"
    # Add more options here if needed
)

# Function to display options in a numbered list
display_options() {
    echo "Choose one of the following options:"
    for ((i=0; i<${#OPTIONS[@]}; i++)); do
        echo "$((i+1)). ${OPTIONS[$i]}"
    done
}

# Main script
display_options
read -p "Enter the number corresponding to your choice: " choice

# Validate user input
if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#OPTIONS[@]} ]]; then
    device_hostname="${OPTIONS[$((choice-1))]}"
    echo "You selected: $device_hostname"
else
    echo "Invalid choice. Please enter a number between 1 and ${#OPTIONS[@]}."
    exit 1
fi

sudo nixos-rebuild switch --flake ".#$device_hostname"
home-manager --flake ".#jstiverson@$device_hostname" switch
