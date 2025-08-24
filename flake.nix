{
  description = "My NixOS system configuration flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, nix-flatpak, agenix, ... }@inputs:
    let
      # NOTE: Utility function for getting all modules for a specific host
      hostModules = host:
        let
          files = builtins.readDir ./hosts/${host};
          nixFiles = builtins.filter (name:
            files.${name} == "regular" && builtins.match "^.*\\.nix$" name
            != null) (builtins.attrNames files);
        in builtins.map (filename: ./hosts/${host}/${filename}) nixFiles;

      # NOTE: Helper variables
      lib = nixpkgs.lib;

      # NOTE: List of modules to import for all hosts
      commonModules =
        [ nix-flatpak.nixosModules.nix-flatpak agenix.nixosModules.default ]
        ++ hostModules "common";
    in {
      nixosConfigurations = {
        younix = lib.nixosSystem (let hostName = "younix";
        in {
          system = "x86_64-linux";
          specialArgs = { inherit hostName; };
          modules = commonModules ++ hostModules hostName;
        });

        nixfly = lib.nixosSystem (let hostName = "nixfly";
        in {
          system = "x86_64-linux";
          specialArgs = { inherit hostName; };
          modules = commonModules ++ hostModules hostName;
        });
      };
    };
}
