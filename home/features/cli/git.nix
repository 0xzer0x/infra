{ config, lib, inputs, ... }:

with lib;
let cfg = config.features.cli.git;
in {
  options.features.cli.git.enable = mkEnableOption "Enable Git configuration";

  imports = [ inputs.agenix.nixosModules.default ];

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

      age.secrets."gitlab-gitconfig.age".file =
        ../../../secrets/gitlab-gitconfig.age;
      includes.gitlab = {
        condition = "hasconfig:remote.*.url:git@gitlab.com:**/**";
        path = config.age.secrets."gitlab-gitconfig.age".path;
      };

      age.secrets."synapse-gitconfig.age".file =
        ../../../secrets/synapse-gitconfig.age;
      includes.synapse = {
        condition =
          "hasconfig:remote.*.url:git@gitlab.internal.synapse-analytics.io:**/**";
        path = config.age.secrets."synapse-gitconfig.age".path;
      };
    };
  };
}
