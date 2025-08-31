{
  # NOTE: Enable SSH
  services.openssh = {
    enable = true;
    ports = [ 30522 ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
