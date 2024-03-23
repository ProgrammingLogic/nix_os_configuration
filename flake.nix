{
  description = "My personal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

        permittedInsecurePackages = [
          "electron-25.9.0"
          "electron-25.8.6"
        ];
      };
    };

    lib = nixpkgs.lib;

  in {
     defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

     homeConfigurations = {
       jstiverson = home-manager.lib.homeManagerConfiguration {
	 inherit pkgs;
 
         modules = [
           ./home-manager/home.nix
	 ];
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
