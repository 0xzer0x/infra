{
  # NOTE: Enable SSH
  services.openssh = {
    enable = true;
    ports = [ 30522 ];
  };

  # NOTE: Add authorized key for user
  users.users.youfathy.openssh = {
    authorizedKeys.keyFiles = [ ./youfathy.key.pub ];
  };
}
