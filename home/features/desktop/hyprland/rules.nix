{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
  floatingWindows = [
    "yad"
    "nm-connection-editor"
    "xdg-desktop-portal-gtk"
    "mousepad"
    "nm-applet"
    "blueman-manager"
    "Wiremix"
  ];
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      layerrule = [
        # NOTE: Remove border around hyprshot screenshots
        "match:namespace selection, no_anim on"
        # NOTE: No animations for rofi
        "match:namespace rofi, no_anim on"
      ];
      # NOTE: Smart gaps
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
      windowrule = [
        # NOTE: Smart gaps
        "match:float 0, match:workspace w[tv1], border_size 0"
        "match:float 0, match:workspace w[tv1], rounding 0"
        "match:float 0, match:workspace f[1], border_size 0"
        "match:float 0, match:workspace f[1], rounding 0"
        # NOTE: Custom rules
        "match:title ^(flameshot), no_anim on"
        "match:initial_class (${builtins.concatStringsSep "|" floatingWindows}), float on"
        "match:initial_class (Wiremix), center on"
        "match:initial_class (Wiremix), size 800 500"
        "match:initial_class ^(com\\.github\\.wwmm\\.easyeffects)$, workspace special:magic"
      ];
    };
  };
}
