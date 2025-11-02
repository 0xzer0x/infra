{ config, lib, ... }:

with lib;
let cfg = config.features.cli.git;
in {
  options.features.cli.git.enable = mkEnableOption "Enable Git configuration";

  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        lfs.enable = true;
        settings.user.name = "Youssef Fathy";
        signing.signByDefault = true;

        includes = let
          githubUser = {
            email = "32334265+0xzer0x@users.noreply.github.com";
            signingKey = "6C64E54946AA83A7EBBFBDD764D4BFCC42B0666B";
          };
          gitlabUser = {
            email = "11070545-0xzer0x@users.noreply.gitlab.com";
            signingKey = "D7AFCE504088C562CB23D7A6B00C69DE35648C40";
          };
          synapseUser = {
            email = "yfathy@synapse-analytics.io";
            signingKey = "95ED403730DF2BFEE61D97DE66660F342809060D";
          };
        in [
          {
            condition = "hasconfig:remote.*.url:git@github.com:**/**";
            contents.user = githubUser;
          }
          {
            condition = "hasconfig:remote.*.url:git@gitlab.com-0xzer0x:**/**";
            contents.user = gitlabUser;
          }
          {
            condition =
              "hasconfig:remote.*.url:git@gitlab.com-yfathy:synapse-analytics/**";
            contents.user = synapseUser;
          }
          {
            condition =
              "hasconfig:remote.*.url:git@gitlab.internal.synapse-analytics.io:**/**";
            contents.user = synapseUser;
          }
        ];
      };

      # NOTE: TUI
      lazygit.enable = true;
    };
  };
}
