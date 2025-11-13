{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.monitor = [
      "DP-1,1920x1080@144,0x0,1"
      ",preferred,auto,1,mirror,DP-1"
    ];
  };
}
