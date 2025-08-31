{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    ../common
    ./hardware.nix
    ./disks.nix
    ./network.nix
    ./virtualization.nix
    ./services.nix
  ];

  authn.youfathy.hashedPasswordFile.enable = false;
}
