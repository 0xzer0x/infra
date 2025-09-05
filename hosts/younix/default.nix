{
  imports = [ ../common ./hardware.nix ./packages.nix ];

  networking.hostName = "younix";
  customization.users.youfathy.hashedPasswordFile.enable = true;
  synapse.wireguard.enable = true;
}

