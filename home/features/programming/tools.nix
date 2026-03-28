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
    programs.mise = {
      enable = true;
      globalConfig = {
        settings.color_theme =
          if (config.features.colorscheme.active == "catppuccin") then "catppuccin" else "default";
      };
    };

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
