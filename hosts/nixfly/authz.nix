{
  security.sudo.extraRules = [{
    groups = [ "users" ];
    commands = [
      # NOTE: Easier for controlling screen brightness
      {
        command = "/run/current-system/sw/bin/brightnessctl";
        options = [ "NOPASSWD" ];
      }
    ];
  }];
}
