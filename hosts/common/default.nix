{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./users
    ./boot.nix
    ./system.nix
    ./services.nix
    ./virtualization.nix
    ./desktop.nix
    ./ricing.nix
    ./nix.nix
    ./ssh.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
