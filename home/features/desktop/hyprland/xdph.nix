{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    xdg.configFile."hypr/xdph.conf" = {
      text = ''
        screencopy {
            max_fps = 60
        }
      '';
    };
  };
}
