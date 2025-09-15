{ config, lib, inputs, ... }:

with lib;
let cfg = config.features.desktop.apps;
in {
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        "app.zen_browser.zen"
        "org.telegram.desktop"
        "com.github.tchx84.Flatseal"
        "org.gtk.Gtk3theme.adw-gtk3"
        "org.gtk.Gtk3theme.adw-gtk3-dark"
        "io.github._0xzer0x.qurancompanion"
      ];

      overrides = {
        global = {
          Context = {
            sockets = [ "wayland" "fallback-x11" "!x11" ];
            devices = [ "dri" ];
            filesystems = [
              # NOTE: Makes system fonts accessible in Flatpaks
              # See https://nixos.wiki/wiki/Fonts
              "/nix/store:ro"
              "xdg-data/fonts:ro"
              "xdg-config/fontconfig:ro"
              # NOTE: Make Flatpaks follow system Gtk theme
              "xdg-config/gtk-3.0:ro"
              "xdg-config/gtk-4.0:ro"
            ];
          };

          Environment = {
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            QT_QPA_PLATFORM = "wayland;xcb";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
            MOZ_DISABLE_RDD_SANDBOX = "1";
            MOZ_ENABLE_WAYLAND = "1";
          };
        };
      };

      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
  };
}
