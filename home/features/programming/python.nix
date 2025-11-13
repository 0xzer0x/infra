{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.programming.python;
in
{
  options.features.programming.python.enable =
    mkEnableOption "Enable Python development configuration";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      uv
      python3
    ];
  };
}
