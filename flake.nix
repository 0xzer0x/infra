{
  description = "My NixOS system configuration flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
  };

  outputs = { self, nixpkgs, nix-flatpak, ... }:
    let lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        younix = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./hardware.nix
            ./boot.nix
            ./network.nix
            ./services.nix
            ./users.nix
            ./system.nix
            ./cli.nix
            ./desktop.nix
            ./flatpak.nix
            ./ricing.nix
            ./nix.nix
          ];
        };

        nixfly = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./hardware.nix
            ./boot.nix
            ./network.nix
            ./services.nix
            ./users.nix
            ./system.nix
            ./power.nix
            ./fi
            ./cli.nix
            ./desktop.nix
            ./flatpak.nix
            ./ricing.nix
            ./nix.nix
          ];
        };
      };
    };
}
