{
  description = "My personal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations.jstiverson-laptop = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     specialArgs = attrs;
     modules = [
      ./nixos/configuration.nix
     ];
    };
  };
}
