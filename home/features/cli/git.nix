{ config, lib, ... }:

with lib;
let
  cfg = config.features.cli.git;
in
{
  options.features.cli.git.enable = mkEnableOption "Enable Git configuration";

  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        lfs.enable = true;
        settings.user.name = "Youssef Fathy";
        signing.signByDefault = true;

        includes =
          let
            githubUser = {
              email = "32334265+0xzer0x@users.noreply.github.com";
              signingKey = "6C64E54946AA83A7EBBFBDD764D4BFCC42B0666B";
            };
            gitlabUser = {
              email = "11070545-0xzer0x@users.noreply.gitlab.com";
              signingKey = "D7AFCE504088C562CB23D7A6B00C69DE35648C40";
            };
          in
          [
            {
              condition = "hasconfig:remote.*.url:git@github.com:**/**";
              contents.user = githubUser;
            }
            {
              condition = "hasconfig:remote.*.url:git@gitlab.com:**/**";
              contents.user = gitlabUser;
            }
          ];
      };

      # NOTE: TUI
      lazygit.enable = true;
    };
  };
}
