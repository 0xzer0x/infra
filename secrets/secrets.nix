let
  youfathy =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcF+abmhnCMZrbz9tLEqEkeUbRsli9o+QOoTZ1FygKh youfathy@agenix";
  users = [ youfathy ];

  nixfly =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMrn/SvMlKKfXr1LmD/wrWHbJootZ3wcRn86ayYMlL1t root@nixfly";
  hosts = [ nixfly ];

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
  "gitlab-gitconfig.age" = {
    publicKeys = default-keys;
    armor = true;
  };
  "synapse-gitconfig.age" = {
    publicKeys = default-keys;
    armor = true;
  };
}

