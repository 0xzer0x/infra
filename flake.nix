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
    # NOTE: Dotfiles inputs
    nvimConfig = {
      url = "github:0xzer0x/nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, agenix, nvimConfig, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      packages = [ (import ./pkgs nixpkgs.legacyPackages.${system}) ];
      overlays = import ./overlays { inherit inputs; };
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        younix = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/younix ];
        };

        nixfly = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixfly ];
        };
      };
    };
}
