{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    ../common
    ./hardware.nix
    ./disks.nix
    ./network.nix
    ./virtualization.nix
  ];

}
