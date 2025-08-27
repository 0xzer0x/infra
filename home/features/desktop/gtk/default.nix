{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.gtk;
in {
  options.features.desktop.gtk.enable = mkEnableOption "Enable GTK theming";

  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      cursorTheme = {
        name = "Adwaita";
        size = 22;
      };

      font = {
        name = "Adwaita Sans";
        size = 10;
      };

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      gtk3 = {
        extraCss = builtins.readFile ./gtk.css;
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
          gtk-decoration-layout = "icon:";
        };
      };

      gtk4 = { extraCss = builtins.readFile ./gtk.css; };
    };
  };
}
