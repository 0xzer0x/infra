{ config, lib, ... }:

with lib;
let cfg = config.features.cli.tmux;
in {
  config = mkIf cfg.enable {
    programs.sesh = {
      enable = true;
      icons = true;
      enableAlias = false;
      enableTmuxIntegration = false;
      settings.session = [
        {
          name = "quran-companion";
          path =
            "${config.home.homeDirectory}/Workspace/github/quran-companion/repository";
          startup_command = "nvim";
        }
        {
          name = "go-pray";
          path = "${config.home.homeDirectory}/Workspace/github/go-pray";
          startup_command = "nvim";
        }
      ];
    };
  };
}

