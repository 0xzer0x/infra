{ pkgs, ... }:

{
  security.sudo.extraRules = [{
    groups = [ "users" ];
    commands = [
      # NOTE: Easier for controlling screen brightness
      {
        command = let lib = pkgs.lib; in lib.getExe pkgs.brightnessctl;
        options = [ "NOPASSWD" ];
      }
    ];
  }];
}
