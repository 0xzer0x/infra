{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
          mirror = "eDP-1";
        }
      ];

      bind = [
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightness inc")'')
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightness dec")'')
          ];
        }
      ];
    };
  };
}
