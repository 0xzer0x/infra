{ config, lib, pkgs, inputs, ... }:

with lib;
let cfg = config.features.cli.tmux;
in {
  options.features.cli.tmux.enable = mkEnableOption "Enable TMUX configuration";

  config = mkIf cfg.enable {
    xdg.configFile."tmux/plugins/tmux-nerd-font-window-name" = {
      source = ./config/plugins/tmux-nerd-font-window-name;
      recursive = true;
    };
    xdg.configFile."tmux/tmux-nerd-font-window-name.yml" = {
      source = ./config/tmux-nerd-font-window-name.yml;
    };

    programs.tmux = {
      enable = true;
      plugins = with pkgs; [{
        plugin = tmuxPlugins.fingers;
        extraConfig = ''
          set -g @fingers-key f
          set -g @fingers-show-copied-notification 0
          set -gF @fingers-hint-style      "fg=green,bold"
          set -gF @fingers-highlight-style "fg=yellow,underscore"
          set -gF @fingers-backdrop-style  "dim"
        '';
      }];
    };

  };
}

