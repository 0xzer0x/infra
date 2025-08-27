{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.rofi;
in {
  options.features.desktop.rofi.enable =
    mkEnableOption "Enable Rofi extended configuration";

  config = mkIf cfg.enable {
    programs.rofi.enable = true;

    xdg.configFile = {
      "rofi/clipboard" = {
        source = ./clipboard;
        recursive = true;
      };

      "rofi/colors" = {
        source = ./colors;
        recursive = true;
      };

      "rofi/gopass" = {
        source = ./gopass;
        recursive = true;
      };

      "rofi/launcher" = {
        source = ./launcher;
        recursive = true;
      };

      "rofi/powermenu" = {
        source = ./powermenu;
        recursive = true;
      };

      "rofi/screenrec" = {
        source = ./screenrec;
        recursive = true;
      };

      "rofi/screenshot" = {
        source = ./screenshot;
        recursive = true;
      };

      "rofi/shared" = {
        source = ./shared;
        recursive = true;
      };
    };
  };
}
