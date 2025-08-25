{
  description = "My NixOS system configuration flake.";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nix-flatpak, agenix, ... }@inputs:
    let lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        younix = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/younix ];
        };

        nixfly = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/nixfly ];
        };
      };
    };
}
