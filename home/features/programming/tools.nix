{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.programming.tools;
in
{
  options.features.programming.tools.enable = mkEnableOption "Enable development environment tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      devbox
      devenv
    ];
  };
}
