{
  description = "My personal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config =  {
        overlays = [ ];

        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      jstiverson = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;

        username = "jstiverson";
        homeDirectory = "/home/jstiverson/";

        configuration = {
          imports = [
            ./home-manager/home.nix
          ];
        };
      };
    };

    nixosConfigurations = {
      jstiverson-desktop = nixpkgs.lib.nixosSystem {
        inherit lib pkgs;

        modules = [
          # Hardware Configuration
          ./hardware/jstiverson-desktop.nix

          # System configuration
          ./nixos/configuration.nix
        ];
      };

      jstiverson-thinkpad = nixpkgs.lib.nixosSystem {
        inherit lib pkgs;
        
        modules = [
          # Hardware Configuration
          ./hardware/jstiverson-thinkpad.nix

          # System configuration
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
