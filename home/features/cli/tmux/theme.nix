{ config, lib, ... }:

with lib;
let
  cfg = config.features.cli.tmux;
in
{
  config = mkIf cfg.enable {
    catppuccin.tmux.extraConfig = ''
      set -g @catppuccin_window_status_style "rounded"

      set -g @catppuccin_directory_icon "󰝰 "
      set -g @catppuccin_date_time_text "%H:%M"

      set -g @catppuccin_gitmux_icon " "
      set -g @catppuccin_gitmux_text "#(gitmux -cfg ${config.xdg.configHome}/tmux/gitmux.conf \"#{pane_current_path}\")"

      set -g @catppuccin_window_text ""
      set -g @catppuccin_window_current_text ""
      set -g @catppuccin_window_number "#[bold]#W(###I) "
      set -g @catppuccin_window_current_number "#[bold]#W(###I#{?window_zoomed_flag,#, ,}#{?pane_synchronized,#, ,}) "
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_current_number_color "#{@thm_green}"

      set -g @catppuccin_window_status_style "custom"
      set -g @catppuccin_window_right_separator "#[fg=#{@_ctp_status_bg},reverse]#[none]"
      set -g @catppuccin_window_left_separator "#[fg=#{@_ctp_status_bg}]#[none]"
      set -g @catppuccin_window_middle_separator "#[bg=#{@catppuccin_window_number_color},fg=#{@catppuccin_window_text_color}]"
      set -g @catppuccin_window_current_middle_separator "#[bg=#{@catppuccin_window_current_number_color},fg=#{@catppuccin_window_current_text_color}]"
    '';
  };
}
