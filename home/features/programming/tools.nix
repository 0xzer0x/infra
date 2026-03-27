{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.programming.tools;
  yaml = pkgs.formats.yaml { };
in
{
  options.features.programming.tools.enable = mkEnableOption "Enable development environment tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      devenv
      posting
    ];

    xdg.configFile."posting/config.yaml" = {
      source = yaml.generate "posting-config.yaml" {
        theme = "catppuccin-mocha";
      };
    };
  };
}
