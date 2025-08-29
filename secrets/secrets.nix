let
  # WARN: Fresh install steps:
  # 1. Copy master secret key to <install-root>/var/lib/agenix/master.key (used for installation only)
  # 2. Install system, remove master key, and reboot
  # 3. Copy generated host key in /var/lib/agenix/host.key to agenix secrets.nix file and add to hosts
  # 4. Copy each user secret key to /var/lib/agenix/<user>.key
  # 5. On master machine, run `agenix -i <path-to-master-key> --rekey` in the secrets directory
  # 6. Pull updated flake in host
  # 7. Rebuild
  #
  # WARN: Each system should only contain:
  # 1. Host unique key generated during installation
  # 2. Each individual user's key
  master =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHe7i9MAtsjMf/TdDyGanZL31AMwv9LQhWbgio/jdrA master@agenix";

  # NOTE: Users
  youfathy =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcF+abmhnCMZrbz9tLEqEkeUbRsli9o+QOoTZ1FygKh youfathy@agenix";
  users = [ youfathy ];

  # NOTE: Hosts
  nixfly =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbZQfbrvsUfFAmyD9wEDmc+mym7Hx1S4Ob2yxzo78nf nixfly@agenix";
  younix =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPuAqJrSOiXo1vmA9S/Az+Saa0Lcm4799OybEY/TYKTU younix@agenix";
  hosts = [ nixfly younix ];

  # NOTE: Helper utilities
  grantOnly = key: [ master key ];
  grantGroup = group: [ master ] ++ group;
in {
  "youfathy.passwd.age" = {
    publicKeys = grantOnly youfathy;
    armor = true;
  };
  "ss-rust.age" = {
    publicKeys = grantGroup hosts;
    armor = true;
  };
  "synapse-wireguard.age" = {
    publicKeys = grantGroup hosts;
    armor = true;
  };
  "synapse-wireguard-dispatcher.age" = {
    publicKeys = grantGroup hosts;
    armor = true;
  };
}

