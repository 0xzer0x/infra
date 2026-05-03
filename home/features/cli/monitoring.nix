{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.cli.monitoring;
in
{
  options.features.cli.monitoring.enable =
    lib.mkEnableOption "Enable system monitoring CLI utilities";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      duf
      lsof
      sysstat
    ];
  };
}
