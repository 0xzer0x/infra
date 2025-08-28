{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = [ "eDP-1,1920x1080@60,0x0,1" ",preferred,auto,1,mirror,eDP-1" ];
      binde = [
        ",XF86MonBrightnessUp, exec, brightness inc"
        ",XF86MonBrightnessDown, exec, brightness dec"
      ];
    };
  };
}
