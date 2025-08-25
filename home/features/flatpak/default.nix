{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    {
      appId = "app.zen_browser.zen";
      origin = "flathub";
    }
    {
      appId = "org.telegram.desktop";
      origin = "flathub";
    }
    {
      appId = "com.github.tchx84.Flatseal";
      origin = "flathub";
    }
    {
      appId = "org.gtk.Gtk3theme.adw-gtk3";
      origin = "flathub";
    }
    {
      appId = "org.gtk.Gtk3theme.adw-gtk3-dark";
      origin = "flathub";
    }
  ];
}
