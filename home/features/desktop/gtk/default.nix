{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.gtk;
in {
  options.features.desktop.gtk.enable = mkEnableOption "Enable GTK theming";

  config = mkIf cfg.enable {
    gtk = let
      extraCss = builtins.readFile ./gtk.css;
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
        gtk-decoration-layout = "icon:";
      };
    in {
      enable = true;
      iconTheme.name = "Papirus-Dark";

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
        inherit extraCss extraConfig;
        # NOTE: File browser bookmarks
        bookmarks = let inherit (config.home) homeDirectory;
        in [ "file:///${homeDirectory}/Workspace Workspace" ];
      };

      gtk4 = { inherit extraCss extraConfig; };
    };

    xdg.dataFile."gtksourceview-4/styles/catppuccin.xml" = {
      source = ./gtksourceview4-style.xml;
    };
  };
}
