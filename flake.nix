{
  description = "NixOS configuration";

  inputs = {
    # default to nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      etsi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/etsi/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/etsi/home.nix;
            };
          }
        ];
      };

      gizu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/gizu/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/gizu/home.nix;
            };
          }
        ];
      };

      lopi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/lopi/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/lopi/home.nix;
            };
          }
        ];
      };

      mika = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/mika/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/mika/home.nix;
            };
          }
        ];
      };

      paku = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/paku/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/paku/home.nix;
              users.aris = import ./hosts/paku/home-aris.nix;
            };
          }
        ];
      };

      pitsi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/pitsi/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/pitsi/home.nix;
            };
          }
        ];
      };

      suna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/etsi/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis = import ./hosts/suna/home.nix;
            };
          }
        ];
      };
    };
  };
}
