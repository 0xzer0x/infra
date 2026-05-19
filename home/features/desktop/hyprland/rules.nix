{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
  floatingWindows = [
    "yad"
    "nm-connection-editor"
    "xdg-desktop-portal-gtk"
    "nm-applet"
    "blueman-manager"
    "Wiremix"
    "org.xfce.mousepad"
  ];
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      layer_rule = [
        # FIX: Remove border around hyprshot screenshots
        # NOTE: No animations for rofi
        {
          match.namespace = "^(selection|rofi)$";
          no_anim = true;
        }
      ];
      # NOTE: Smart gaps
      workspace_rule = [
        {
          workspace = "w[tv1]";
          gaps_in = 0;
          gaps_out = 0;
        }
        {
          workspace = "f[1]";
          gaps_in = 0;
          gaps_out = 0;
        }
      ];
      window_rule = [
        # NOTE: Smart gaps
        {
          match = {
            workspace = "w[tv1]";
            float = false;
          };
          border_size = 0;
          rounding = 0;
        }
        {
          match = {
            workspace = "f[1]";
            float = false;
          };
          border_size = 0;
          rounding = 0;
        }
        {
          match.title = "^(flameshot)$";
          no_anim = true;
        }
        {
          match.initial_class = "^(${builtins.concatStringsSep "|" floatingWindows})$";
          float = true;
        }
        {
          match.initial_class = "^(Wiremix)$";
          center = true;
          size = [
            800
            500
          ];
        }
        {
          match.initial_class = "^(com\\.github\\.wwmm\\.easyeffects)$";
          workspace = "special:hidden";
        }
      ];
    };
  };
}
