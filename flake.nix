{
    # source: https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/flake.nix
    description = "Jonathyn's Nix configuration";

    inputs = {
        # Nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

        # Home Manager
        home-manager.url = "github:nix-community/home-manager/release-23.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };


    outputs = {
        self,
        nixkgs,
        home-manager,
        ...
    } @ inputs: let 
        inherit (self) outputs;
    in {
        nixosConfigurations = {
            # FIXME replace with your hostname
            your-hostname = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                # > Our main nixos configuration file <
                modules = [./nixos/configuration.nix];
            };
        };

        homeConfigurations = {
        # FIXME replace with your username@hostname
        "jstiverson@jstiverson-laptop" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = {inherit inputs outputs;};
            # > Our main home-manager configuration file <
            modules = [./home-manager/home.nix];
        };
    };
}