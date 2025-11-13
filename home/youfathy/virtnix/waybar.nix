{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.waybar;
in
{
  config = mkIf cfg.enable {
    programs.waybar.settings.hyprland-statusbar = {
      modules-right = [
        "network"
        "custom/separator"
        "custom/go-pray"
        "custom/separator"
        "cpu"
        "memory"
        "custom/separator"
        "pulseaudio"
        "custom/separator"
        "hyprland/language"
        "custom/separator"
        "clock"
        "custom/separator"
        "tray"
      ];
    };
  };
}
