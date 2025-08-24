{
  description = "My NixOS system configuration flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
  };

  outputs = { self, nixpkgs, nix-flatpak, ... }:
    let
      lib = nixpkgs.lib;
      commonModules = [
        nix-flatpak.nixosModules.nix-flatpak
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
    in {
      nixosConfigurations = {
        younix = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { hostName = "younix"; };
          modules = commonModules ++ [ ./hosts/younix/hardware.nix ];
        };

        nixfly = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { hostName = "nixfly"; };
          modules = commonModules
            ++ [ ./hosts/nixfly/hardware.nix ./power.nix ./fingerprint.nix ];
        };
      };
    };
}
