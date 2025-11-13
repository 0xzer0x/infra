{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.terminal;
in
{
  options.features.desktop.terminal.alacritty.enable = mkOption {
    type = types.bool;
    description = "Enable Alacritty terminal configuration";
    default = cfg.default == "alacritty";
  };

  config = mkIf cfg.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        terminal = {
          shell = "tmux";
        };
        font = {
          size = 11;
        };
      };
    };
  };
}
