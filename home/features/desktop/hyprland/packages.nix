{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      overlayPackages.papirus-icon-theme
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
      wiremix
      pavucontrol
      ffmpegthumbnailer
      seahorse
      gcr
      poppler-utils
      gthumb
      nemo-with-extensions
    ];

    programs.swaylock.enable = true;

    # NOTE: Notifications daemon
    services.dunst = {
      enable = true;
      settings = {
        global = {
          font = "monospace, 10";
          icon_theme = "Papirus-Dark";
          separator_color = "frame";
          offset = "(5, 5)";
          frame_width = 2;
          corner_radius = 0;
          gap_size = 2;
          progress_bar_height = 15;
          progress_bar_corner_radius = 0;
          always_run_script = true;
          enable_recursive_icon_lookup = true;
          mouse_left_click = "do_action, close_current";
        };
      };
    };
    systemd.user.services.dunst.Install.WantedBy = [ "graphical-session.target" ];

    services = {
      # NOTE: NetworkManager applet
      network-manager-applet.enable = true;

      # NOTE: Authentication agent
      polkit-gnome.enable = true;

      # NOTE: Wallpaper manager
      swww.enable = true;
    };

    dconf.settings = {
      "org/nemo/preferences" = {
        "disable-menu-warning" = true;
      };
      "org/nemo/window-state" = {
        "maximized" = true;
        "my-computer-expanded" = true;
        "bookmarks-expanded" = true;
        "devices-expanded" = false;
        "network-expanded" = false;
        "start-with-menu-bar" = false;
        "start-with-status-bar" = false;
        "start-with-sidebar" = true;
        "sidebar-bookmark-breakpoint" = 0;
      };
      "org/virt-manager/virt-manager/details" = {
        "show-toolbar" = false;
      };
    };
  };
}
