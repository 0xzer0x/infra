{ config, lib, ... }:

let
  cfg = config.features.cli.github;
in
{
  options.features.cli.github.enable = lib.mkEnableOption "Enable GitHub CLI utilities";

  config = lib.mkIf cfg.enable {
    programs = {
      # NOTE: GitHub official CLI
      gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
        };
      };

      # NOTE: TUI dashboard plugin
      gh-dash.enable = true;
    };
  };
}
