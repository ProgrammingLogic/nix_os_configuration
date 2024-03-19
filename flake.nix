{
        description = "NixOS Configuration";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
                home-manager.url = "github:nix-community/home-manager";
                home-manager.inputs.nixpkgs.follows = "nixpkgs";
        };

        outputs = inputs@{ nixpkgs, home-manager, ...}: {
                nixosConfigurations = {
                        hostname = nixpklgs.lib.nixosSystem {
                                system = "x86_64-linux";
                                modules = [
                                        ./configuration.nix
                                        home-manager.nixosModules.home-manager
                                        {
                                                home-manager.useGlobalPkgs = true;
                                                home-manager.useUserPackages = true;
                                                home-manager.users.jstiverson = import ./home.nix;
                                        }
                                ];
                        };
                };
        };
};
