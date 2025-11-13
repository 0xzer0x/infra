{ config, lib, ... }:

with lib;
let
  cfg = config.features.cli.virtualization;
in
{
  config = mkIf cfg.enable {
    home.sessionVariables = {
      LIMA_HOME = mkForce "/mnt/ssd/Virtualization/lima/data";
    };
  };
}
