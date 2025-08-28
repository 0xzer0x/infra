{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./users
    ./agenix.nix
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
    extraSpecialArgs = { inherit inputs outputs; };
  };
}
