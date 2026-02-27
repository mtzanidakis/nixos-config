{
  description = "NixOS configuration";

  inputs = {
    # default to nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code.url = "github:sadjow/claude-code-nix";
    golazo.url = "github:0xjuanma/golazo";
    msgvault.url = "github:wesm/msgvault";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    catppuccin,
    claude-code,
    golazo,
    msgvault,
    ...
  }: let
    claude-code-overlay = {nixpkgs.overlays = [claude-code.overlays.default];};
    golazo-overlay = {nixpkgs.overlays = [(final: prev: {
      golazo = prev.buildGoModule {
        pname = "golazo";
        version = "0.21.0";
        src = golazo;
        vendorHash = "sha256-M2gfqU5rOfuiVSZnH/Dr8OVmDhyU2jYkgW7RuIUTd+E=";
        subPackages = ["."];
      };
    })];};
    msgvault-overlay = {nixpkgs.overlays = [(final: prev: {
      msgvault = msgvault.packages.${prev.system}.default;
    })];};
  in {
    nixosConfigurations = {
      etsi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/etsi/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/etsi/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      gizu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/gizu/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/gizu/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      kiki = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/kiki/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/kiki/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      mika = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/mika/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/mika/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      suna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/suna/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/suna/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      teko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/teko/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/teko/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      zumi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/zumi/configuration.nix
          claude-code-overlay
          golazo-overlay
          msgvault-overlay
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.manolis.imports = [
                ./hosts/zumi/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

    };
  };
}
