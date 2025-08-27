{ config, lib, ... }:

with lib;
let cfg = config.features.cli.git;
in {
  options.features.cli.git.enable = mkEnableOption "Enable Git configuration";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = "Youssef Fathy";
      userEmail = "32334265+0xzer0x@users.noreply.github.com";
      signing = {
        key = "6C64E54946AA83A7EBBFBDD764D4BFCC42B0666B";
        signByDefault = true;
      };

      includes = [
        {
          condition = "hasconfig:remote.*.url:git@gitlab.com:**/**";
          contents.user = {
            email = "11070545-0xzer0x@users.noreply.gitlab.com";
            signingKey = "D7AFCE504088C562CB23D7A6B00C69DE35648C40";
          };
        }
        {
          condition =
            "hasconfig:remote.*.url:git@gitlab.internal.synapse-analytics.io:**/**";
          contents.user = {
            email = "yfathy@synapse-analytics.io";
            signingKey = "95ED403730DF2BFEE61D97DE66660F342809060D";
          };
        }
      ];
    };
  };
}
