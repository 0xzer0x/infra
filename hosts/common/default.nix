{ inputs, outputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    ./users
    ./synapse
    ./sops.nix
    ./boot.nix
    ./system.nix
    ./network.nix
    ./services.nix
    ./virtualization.nix
    ./desktop.nix
    ./fonts.nix
    ./nix.nix
  ];

  home-manager = {
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs outputs; };
  };
}
