{
  description = "My NixOS system configuration flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # NOTE: Secrets management
    agenix.url = "github:ryantm/agenix";
    # NOTE: Disks and partitioning
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    # NOTE: User dotfiles management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: Colorscheme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: Dotfiles
    nvimdots = {
      url = "github:0xzer0x/nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, agenix, nvimdots, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      packages = {
        "${system}" = (import ./pkgs nixpkgs.legacyPackages.${system});
      };
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

        virtnix = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/virtnix ];
        };
      };
    };
}
