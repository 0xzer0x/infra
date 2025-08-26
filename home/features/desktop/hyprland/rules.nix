{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
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
        "noinitialfocus,class:(xwaylandvideobridge)"
        "size 0 0,class:(xwaylandvideobridge)"
        "float,class:(yad|nm-connection-editor)"
        "float,class:(xdg-desktop-portal-gtk)"
        "float,class:(mousepad)"
        "float,class:(audacious)"
        "float,class:(pavucontrol)"
        "float,class:(nm-applet)"
        "float,class:(blueman-manager)"
        "float,class:^(org\\.telegram\\.desktop)$"
        "center,class:^(org\\.telegram\\.desktop)$"
        "float,class:(nemo)"
        "center,class:(nemo)"
        "size 1000 600,class:(nemo),title:(Home|Downloads)"
        "workspace special:magic,class:^(com\\.github\\.wwmm\\.easyeffects)$"
      ];
    };
  };
}
