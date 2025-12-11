{
  config,
  lib,
  inputs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.apps;
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        "com.github.tchx84.Flatseal"
        "org.gtk.Gtk3theme.adw-gtk3"
        "org.gtk.Gtk3theme.adw-gtk3-dark"
        "io.github._0xzer0x.qurancompanion"
        "com.rustdesk.RustDesk"
      ];

      overrides = {
        global = {
          Context = {
            sockets = [
              "wayland"
              "fallback-x11"
              "!x11"
            ];
            devices = [ "dri" ];
            filesystems = [
              # NOTE: Pass user fonts and fontconfig (system fonts should be available by default under /run/host)
              "xdg-config/fontconfig:ro"
              # NOTE: Make Flatpaks follow system Gtk theme
              "/nix/store:ro"
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
