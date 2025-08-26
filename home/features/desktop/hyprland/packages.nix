{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      hyprpaper
      hyprshot
      swaylock
      rofi-wayland
      dunst
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
