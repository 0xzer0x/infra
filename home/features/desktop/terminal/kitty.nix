{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.terminal;
in {
  options.features.desktop.terminal.kitty.enable = mkOption {
    type = types.bool;
    description = "Enable kitty terminal configuration";
    default = cfg.default == "kitty";
  };

  config = mkIf cfg.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "monospace";
        size = 11;
      };
      settings = {
        shell = "tmux";
        tab_bar_style = "hidden";
        confirm_os_window_close = 0;
      };
    };
  };
}

