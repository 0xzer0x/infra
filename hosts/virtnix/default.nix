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

  networking.hostName = "virtnix";
  customization.users.youfathy.hashedPasswordFile.enable = false;
}
