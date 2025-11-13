{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.gtk;
in
{
  options.features.desktop.gtk.enable = mkEnableOption "Enable GTK theming";

  config = mkIf cfg.enable {
    gtk =
      let
        extraCss = builtins.readFile ./gtk.css;
      in
      {
        enable = true;
        iconTheme.name = "Papirus-Dark";

        cursorTheme = {
          name = "Adwaita";
          size = 22;
        };

        font = {
          name = builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0;
          size = 10;
        };

        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };

        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

        gtk3 = {
          inherit extraCss;
          # NOTE: File browser bookmarks
          bookmarks =
            let
              inherit (config.home) homeDirectory;
            in
            [ "file:///${homeDirectory}/Workspace Workspace" ];
          extraConfig = {
            gtk-application-prefer-dark-theme = true;
            gtk-decoration-layout = "menu:";
          };
        };

        gtk4 = {
          inherit extraCss;
          extraConfig = {
            gtk-decoration-layout = "menu:";
          };
        };
      };

    # NOTE: GTK4 configuration
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        "color-scheme" = "prefer-dark";
      };
    };

    xdg.dataFile."gtksourceview-4/styles/catppuccin.xml" = {
      source = ./gtksourceview4-style.xml;
    };
  };
}
