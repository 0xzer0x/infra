{
  imports = [ ../common ./hardware.nix ./network.nix ./packages.nix ];

  authn.youfathy.hashedPasswordFile.enable = true;
}

