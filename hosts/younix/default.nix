{
  imports = [ ../common ./hardware.nix ./network.nix ./packages.nix ];

  networking.hostName = "younix";
  authn.youfathy.hashedPasswordFile.enable = true;
}

