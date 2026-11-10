{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    # NOTE: Theme for hyprland-share-picker
    catppuccin.hyprtoolkit.enable = true;

    wayland.windowManager.hyprland.xdph.settings.screencopy = {
      max_fps = 60;
    };
  };
}
