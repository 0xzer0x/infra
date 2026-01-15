{
  imports = [
    ../common
    ./hardware.nix
    ./network.nix
    ./packages.nix
  ];

  networking.hostName = "younix";
  customization.users.youfathy.hashedPasswordFile.enable = true;
  work.synapse = {
    wireguard.enable = true;
    openfortivpn.enable = true;
  };
}
