{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "org.telegram.desktop"
    "com.github.tchx84.Flatseal"
    "org.gtk.Gtk3theme.adw-gtk3"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
  ];
}
