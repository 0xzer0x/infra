{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      papirus-icon-theme
      xdg-utils
      xdg-launch
      xdg-user-dirs
      desktop-file-utils
      vdpauinfo
      libva-vdpau-driver
      libvdpau-va-gl
      hyprshot
      libnotify
      adw-gtk3
      nwg-look
      nwg-displays
      pavucontrol
      nemo-with-extensions
      ffmpegthumbnailer
      seahorse
      gcr
      poppler-utils
      audacious
      gthumb
    ];

    services.polkit-gnome.enable = true;

    programs = {
      swww.enable = true;
      swaylock.enable = true;

      # NOTE: Notifications daemon
      dunst = {
        enable = true;
        settings = {
          global = {
            font = "monospace, 10";
            icon_theme = "Papirus-Dark";
            separator_color = "frame";
            offset = "(5, 5)";
            frame_width = 2;
            corner_radius = 6;
            gap_size = 2;
            progress_bar_height = 15;
            progress_bar_corner_radius = 2;
            always_run_script = true;
            enable_recursive_icon_lookup = true;
            mouse_left_click = "do_action, close_current";
          };
        };
      };
    };

  };
}
