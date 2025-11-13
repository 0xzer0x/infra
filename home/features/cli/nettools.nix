{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.cli.nettools;
in
{
  options.features.cli.nettools.enable =
    mkEnableOption "Enable CLI network monitoring and analysis utilities";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libpcap
      tcpdump
      tshark
      vnstat
      dogdns
      ldns
    ];
  };
}
