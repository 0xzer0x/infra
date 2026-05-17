{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.hyprland;
  nvidiaVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
in
{
  config = mkIf cfg.enable {
    home.sessionVariables = nvidiaVariables;
    wayland.windowManager.hyprland.settings = {
      env = lib.attrsets.mapAttrsToList (name: value: {
        _args = [
          name
          (toString value)
        ];
      }) nvidiaVariables;

      monitor = [
        {
          output = "DP-1";
          mode = "1920x1080@144";
          position = "0x0";
          scale = 1;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
          mirror = "DP-1";
        }
      ];
    };
  };
}
