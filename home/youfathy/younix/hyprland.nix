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
      env = lib.attrsets.mapAttrsToList (name: value: "${name},${toString value}") nvidiaVariables;
      monitor = [
        "DP-1,1920x1080@144,0x0,1"
        ",preferred,auto,1,mirror,DP-1"
      ];
    };
  };
}
