{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.waybar;
in {
  options.features.desktop.waybar.enable =
    mkEnableOption "Enable Waybar extended configuration";

  config = mkIf cfg.enable { };
}
