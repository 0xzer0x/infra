{ inputs, ... }:

{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./boot.nix
    ./cli.nix
    ./desktop.nix
    ./flatpak.nix
    ./nix.nix
    ./ricing.nix
    ./services.nix
    ./system.nix
    ./users
  ];
}
