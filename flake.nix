{
    description = "NixOS config";

    nixConfig = {
        extra-substituters = [ "https://herdr.cachix.org" ];
        extra-trusted-public-keys = [
            "herdr.cachix.org-1:3nH7IStRsS0ASfdonA0DCRR2ZrSCeWitZ7Kwew0cR4I="
        ];
    };

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        herdr-nix.url = "github:herdrdev/herdr-nix";
    };

    outputs = { nixpkgs, home-manager, herdr-nix, ... }: {
        nixosConfigurations.act = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
                herdr = herdr-nix.packages.x86_64-linux.default;
            };
            modules = [
                ./hosts/act/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.cet = import ./hosts/act/home.nix;
                }
            ];
        };
    };
}
