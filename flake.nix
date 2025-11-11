{
  description = "My NixOS system configuration flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # NOTE: Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    # NOTE: Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # NOTE: Extra packages flakes
    go-pray = {
      url = "github:0xzer0x/go-pray";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: SF Fonts
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: Colorscheme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: Externally-managed dotfiles
    nvimdots = {
      url = "github:0xzer0x/nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      system = "x86_64-linux";
    in {
      lib = (import ./lib { inherit (nixpkgs) lib; });
      packages.${system} = (import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        younix = nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/younix ];
        };

        nixfly = nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixfly ];
        };

        virtnix = nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/virtnix ];
        };
      };
    };
}
