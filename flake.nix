{
  description = "My personal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations.jstiverson-laptop = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     specialArgs = attrs;
     modules = [
      ./nixos/configuratuion.nix
     ];
    };
  };
}
