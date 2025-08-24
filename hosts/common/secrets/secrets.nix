let
  youfathy =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcF+abmhnCMZrbz9tLEqEkeUbRsli9o+QOoTZ1FygKh youfathy@agenix";
in {
  "ss-rust.age" = {
    publicKeys = [ youfathy ];
    armor = true;
  };
}

