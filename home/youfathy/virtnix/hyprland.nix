{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.monitor =
      [ "Virtual-1,1280x720@60,0x0,1" ",preferred,auto,1,mirror,Virtual-1" ];
  };
}
