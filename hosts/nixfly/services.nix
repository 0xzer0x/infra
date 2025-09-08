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

  # NOTE: Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
