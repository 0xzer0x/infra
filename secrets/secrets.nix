let
  youfathy =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcF+abmhnCMZrbz9tLEqEkeUbRsli9o+QOoTZ1FygKh youfathy@agenix";
  users = [ youfathy ];

  nixfly =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbZQfbrvsUfFAmyD9wEDmc+mym7Hx1S4Ob2yxzo78nf root@nixfly";
  younix =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPuAqJrSOiXo1vmA9S/Az+Saa0Lcm4799OybEY/TYKTU younix@agenix";
  hosts = [ nixfly younix ];

  default-keys = [ youfathy ] ++ hosts;
in {
  "ss-rust.age" = {
    publicKeys = default-keys;
    armor = true;
  };
  "synapse-wireguard.age" = {
    publicKeys = default-keys;
    armor = true;
  };
  "synapse-wireguard-dispatcher.age" = {
    publicKeys = default-keys;
    armor = true;
  };
}

