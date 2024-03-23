# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    username = "jstiverson";
    homeDirectory = "/home/jstiverson";

    packages = [
      # Internet
      pkgs.firefox

      # Development
      pkgs.python3
      pkgs.vscode
      pkgs.git

      # Productivity
      pkgs.libreoffice
      pkgs.obsidian

      # Communication
      pkgs.discord
      pkgs.signal-desktop

      # Privacy & Security
      pkgs.bitwarden

      # Entertainment
      pkgs.spotify
      pkgs.steam

      # System
      pkgs.syncthing
      pkgs.syncthing-tray

      # Audio / video
      pkgs.vlc 
    ];
  };

  programs = {
    git =  {
      enable = true;
      lfs.enable = true;

      userName = "Jonathyn Stiverson";
      userEmail = "jlstiverson2002@protonmail.com";

      aliases = {
          gc = "commit";
          gp = "push";
          ga = "add";
      };
    };
  };
}
