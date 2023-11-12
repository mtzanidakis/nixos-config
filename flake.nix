{
  description = "My nixos configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      manolis-monstro = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/manolis-monstro/home.nix
        ];
      };
    };

    nixosConfigurations = {
      monstro = lib.nixosSystem {
        inherit system;
        modules = [
          ./systems/monstro/configuration.nix
        ];
      };
    };
  };
}
