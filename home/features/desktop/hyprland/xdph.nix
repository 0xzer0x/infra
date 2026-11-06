{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.xdph.settings.screencopy = {
      max_fps = 60;
    };
  };
}
