{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      layerrule = [
        # NOTE: Remove border around hyprshot screenshots
        "noanim, selection"
        # NOTE: No animations for rofi
        "noanim, rofi"
      ];
      # NOTE: Smart gaps
      workspace = [ "w[tv1], gapsout:0, gapsin:0" "f[1], gapsout:0, gapsin:0" ];
      windowrulev2 = [
        # NOTE: Smart gaps
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
        # NOTE: Custom rules
        "noanim,title:^(flameshot)"
        "float,class:(yad|nm-connection-editor)"
        "float,class:(xdg-desktop-portal-gtk)"
        "float,class:(mousepad)"
        "float,class:(nm-applet)"
        "float,class:(blueman-manager)"
        "float,class:(Wiremix)"
        "center,class:(Wiremix)"
        "size 800 500,class:(Wiremix)"
        "workspace special:magic,class:^(com\\.github\\.wwmm\\.easyeffects)$"
      ];
    };
  };
}
