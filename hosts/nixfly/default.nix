{
  imports = [
    ../common
    ./authz.nix
    ./fingerprint.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./power.nix
    ./services.nix
  ];

  networking.hostName = "nixfly";
  authn.youfathy.hashedPasswordFile.enable = true;
}
