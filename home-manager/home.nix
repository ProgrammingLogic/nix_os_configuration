# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }:
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  nixpkgs = {
    overlays = [];

    # Might be able to these, not sure.
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home-manager.users.jstiverson  = {
    programs.home-manager.enable = true;

    home = {
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "23.05";

      username  = "jstiverson";
      homeDirectory = "/home/jstiverson";

      packages = [
        # Internet
        firefox

        # Development
        git
        python3
        vscode

        # Productivity
        libreoffice
        obsidian

        # Communication
        discord
        signal-desktop

        # Privacy & Security
        bitwarden

        # Entertainment
        spotify
        steam

        # System
        syncthing
        syncthing-tray

        # Audio / video
        vlc 
      ];

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
        }
      };

    }
  };
}
