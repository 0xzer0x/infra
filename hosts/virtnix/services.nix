{
  # NOTE: Enable SSH
  services.openssh = {
    enable = true;

    banner = ''
      [ SYSTEM STATUS: ACTIVE | AUTHORIZED LINK ESTABLISHED ]
      Welcome back, Administrator.
      The system has been waiting for you.
    '';

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
