{ inputs, ... }:

{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./users
    ./boot.nix
    ./system.nix
    ./services.nix
    ./virtualization.nix
    ./desktop.nix
    ./ricing.nix
    ./nix.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
