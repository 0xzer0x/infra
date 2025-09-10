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

      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
  };
}
