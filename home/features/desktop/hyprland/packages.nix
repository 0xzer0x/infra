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
      swww
      hyprpaper
      hyprshot
      swaylock
      dunst
      libnotify
      adw-gtk3
      nwg-look
      nwg-displays
      pavucontrol
      nemo-with-extensions
      ffmpegthumbnailer
      seahorse
      gcr
      zathura
      poppler-utils
      flameshot
      audacious
      gthumb
    ];

    services.polkit-gnome.enable = true;
  };
}
