# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ flake, pkgs, ... }:
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  nix = {
    registry.nixpkgs.flake = flake.inputs.nixpkgs;

    gc = {
      automatic = true;
    };
  };

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
        pkgs.firefox

        # Development
        pkgs.git
        pkgs.python3
        pkgs.vscode

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
    };
  };
}
