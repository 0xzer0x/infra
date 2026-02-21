{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.terminal;
in
{
  options.features.desktop.terminal.ghostty.enable = mkOption {
    type = types.bool;
    description = "Enable ghostty terminal configuration";
    default = cfg.default == "ghostty";
  };

  config = mkIf cfg.ghostty.enable {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;
      settings = {
        font-family = "monospace";
        font-size = 11;
        command = "tmux -N";
        working-directory = "home";
        window-decoration = "none";
        window-show-tab-bar = "never";
        resize-overlay = "never";
        quit-after-last-window-closed = false;
      };
    };
  };
}
