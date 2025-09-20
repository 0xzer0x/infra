{ pkgs, ... }:

{
  security.sudo.extraRules = [{
    groups = [ "users" ];
    commands = [
      # NOTE: Easier for controlling screen brightness
      {
        command = "${pkgs.brightnessctl}/bin/brightnessctl";
        options = [ "NOPASSWD" ];
      }
    ];
  }];
}
