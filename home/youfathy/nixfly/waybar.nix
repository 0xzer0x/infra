{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.waybar;
in
{
  config = mkIf cfg.enable {
    programs.waybar.settings.hyprland-statusbar = {
      battery = {
        interval = 15;
        bat = "BAT0";
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
        max-length = 100;
      };
      backlight = {
        format = "{icon}  {percent}%";
        format-icons = [
          ""
          ""
        ];
        max-length = 100;
      };
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
        "backlight"
        "custom/separator"
        "battery"
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
