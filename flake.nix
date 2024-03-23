{
  description = "My personal Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home manager
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
