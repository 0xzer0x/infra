{
  description = "My NixOS system configuration flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
  };

  outputs = { self, nixpkgs, nix-flatpak, ... }@inputs:
    let
      # NOTE: Utility function for getting all modules for a specific host
      hostModules = host:
        let files = builtins.readDir ./hosts/${host};
        in builtins.filter (name:
          files.${name} == "regular" && builtins.match "^.*\\.nix$" name
          != null) (builtins.attrNames files);

      # NOTE: Helper variables
      lib = nixpkgs.lib;
      commonModules = [ nix-flatpak.nixosModules.nix-flatpak ]
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
