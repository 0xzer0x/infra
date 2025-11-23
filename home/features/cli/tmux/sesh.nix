{ config, lib, ... }:

with lib;
let
  cfg = config.features.cli.tmux;
  inherit (config.home) homeDirectory;
  workspaceDir = "${homeDirectory}/Workspace";
  editorSessions =
    builtins.map
      (
        { name, path }:
        {
          inherit name path;
          startup_command = config.home.sessionVariables.EDITOR;
        }
      )
      [
        {
          name = "quran-companion";
          path = "${workspaceDir}/github/quran-companion/repository";
        }
        {
          name = "go-pray";
          path = "${workspaceDir}/github/go-pray";
        }
        {
          name = "infra";
          path = "${config.xdg.configHome}/infra";
        }
      ];
in
{
  config = mkIf cfg.enable {
    programs.sesh = {
      enable = true;
      icons = true;
      enableAlias = false;
      enableTmuxIntegration = false;
      settings.session = editorSessions;
    };
  };
}
