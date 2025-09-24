{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.features.desktop.rofi;
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  options.features.desktop.rofi.enable =
    mkEnableOption "Enable Rofi extended configuration";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ grim slurp pulseaudio ];

    programs = {
      rofi = {
        enable = true;
        modes = [ "drun" "run" "window" "passmenu" ];

        extraConfig = {
          # NOTE: Vim-like navigation in vertical menus
          kb-row-up = "Control+k";
          kb-row-down = "Control+j";
          kb-accept-entry = "Return";
          kb-mode-complete = "Control+Shift+l";
          kb-remove-to-eol = "Control+Shift+u";
          kb-remove-char-back = "BackSpace";
          # NOTE: Additional configuration
          show-icons = false;
          display-drun = " ";
          display-run = " ";
          display-window = " ";
          drun-display-format = "{name}";
          window-format = "{w} · {c} · {t}";
        };

        theme = {
          window = { width = mkLiteral "600px"; };

          element = { padding = mkLiteral "0 0.5em 0 0.5em"; };
        };
      };
    };

    xdg.configFile = {
      "rofi/runners" = {
        source = ./runners;
        recursive = true;
      };

      "rofi/scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };
  };
}
