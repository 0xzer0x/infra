{
  config,
  lib,
  pkgs,
  ...
}:

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
      gh-dash = {
        enable = true;
        settings = {
          keybindings.prs =
            let
              tuicr = lib.getExe pkgs.tuicr;
            in
            [
              {
                name = "Code review";
                key = "C";
                command = "${tuicr} pr {{ .PrNumber }}";
              }
            ];
        };
      };
    };
  };
}
