{
  imports = [
    ../common
    ./authz.nix
    ./fingerprint.nix
    ./hardware.nix
    ./packages.nix
    ./power.nix
    ./services.nix
  ];

  networking.hostName = "nixfly";
  customization.users.youfathy.hashedPasswordFile.enable = true;
  synapse.wireguard.enable = true;
}
