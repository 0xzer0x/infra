{ inputs, outputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    ./users
    ./sops.nix
    ./boot.nix
    ./system.nix
    ./network.nix
    ./services.nix
    ./virtualization.nix
    ./desktop.nix
    ./ricing.nix
    ./nix.nix
    ./synapse.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };
}
