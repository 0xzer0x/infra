{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.gtk;
in {
  options.features.desktop.gtk.enable = mkEnableOption "Enable GTK theming";

  config = mkIf cfg.enable {
    gtk = {
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
        extraCss = builtins.readFile ./gtk.css;
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
          gtk-decoration-layout = "icon:";
        };
        # NOTE: File browser bookmarks
        bookmarks = let inherit (config.home) homeDirectory;
        in [
          "file:///${homeDirectory}/Documents Documents"
          "file:///${homeDirectory}/Downloads Downloads"
          "file:///${homeDirectory}/Audio Audio"
          "file:///${homeDirectory}/Pictures Pictures"
          "file:///${homeDirectory}/Videos Videos"
          "file:///${homeDirectory}/Workspace Workspace"
        ];
      };

      gtk4 = { extraCss = builtins.readFile ./gtk.css; };
    };
  };
}
