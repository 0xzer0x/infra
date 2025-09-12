{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.waybar;
in {
  config = mkIf cfg.enable {
    programs.waybar.settings.hyprland-statusbar = {
      "custom/separator" = {
        "format" = "|";
        "interval" = "once";
        "tooltip" = false;
      };
      "custom/go-pray" = {
        "interval" = 60;
        "return-type" = "json";
        "exec" = "${config.xdg.configHome}/waybar/scripts/go-pray";
        "format" = "󱠧  {}";
      };
      "custom/record-status" = {
        "interval" = 60;
        "return-type" = "json";
        "exec" = "${config.xdg.configHome}/waybar/scripts/record-status";
        "on-click" = "${config.xdg.configHome}/rofi/runners/screenrec";
        "signal" = 1;
      };
    };
  };
}
