{ config, lib, ... }:

with lib;
let
  cfg = config.features.cli.yazi;
in
{
  config = mkIf cfg.enable {
    programs.yazi.keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "g"
            "s"
          ];
          run = "cd /mnt/ssd";
          desc = "Go to /mnt/ssd";
        }
        {
          on = [
            "g"
            "W"
          ];
          run = "cd /mnt/ssd/Work";
          desc = "Go to /mnt/ssd/Work";
        }
      ];
    };
  };
}
