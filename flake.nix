{
  description = "My personal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  

  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  } @ inputs: 
  let inherit (self) outputs; in {
    homeConfigurations = {
      "jstiverson@jstiverson-thinkpad" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };

    nixosConfigurations = {
      jstiverson-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };

        modules = [
          # Hardware Configuration
          ./hardware/jstiverson-desktop.nix

          # System configuration
          ./nixos/configuration.nix

        ];
      };

      jstiverson-thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        
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
