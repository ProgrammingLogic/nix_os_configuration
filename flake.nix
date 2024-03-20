{
  description = "My personal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # home-manager.url = "github:nix-community/home-manager/release-23.05";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  

  outputs = { 
    self, 
    nixpkgs, 
    #  home-manager, 
    ... 
  } @ inputs: 
  let inherit (self) outputs; in {
    nixosConfigurations = {
      jstiverson-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        
        # # Home-manager requires 'pkgs' instance
        # pkgs = nixpkgs.legacyPackages.x86_64-linux; 

        modules = [
          # System configuration
          ./nixos/configuration.nix

          # # User configuration
          # ./home-manager/home.nix
        ];
      };
    };
  };
}
