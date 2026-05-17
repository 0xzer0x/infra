{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.qt;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      kdePackages.breeze.qt5
    ];

    xdg.configFile."qt5ct/colors/Catppuccin-Mocha.conf" = {
      enable = true;
      source = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/catppuccin-mocha-blue.conf";
    };

    qt.qt5ctSettings = {
      Appearance = {
        style = "Breeze";
        standard_dialogs = "default";
        icon_theme = "Papirus-Dark";
        custom_palette = true;
        color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/Catppuccin-Mocha.conf";
      };

      Fonts = {
        fixed = ''"${config.gtk.font.name},10,-1,5,50,0,0,0,0,0"'';
        general = ''"${config.gtk.font.name},10,-1,5,50,0,0,0,0,0"'';
      };

      Interface = {
        activate_item_on_single_click = "1";
        buttonbox_layout = "3";
        cursor_flash_time = "1000";
        dialog_buttons_have_icons = "1";
        double_click_interval = "400";
        keyboard_scheme = "2";
        menus_have_icons = "true";
        show_shortcuts_in_context_menus = "true";
        toolbutton_style = "4";
        underline_shortcut = "1";
        wheel_scroll_lines = "3";
      };

      Troubleshooting = {
        force_raster_widgets = "1";
      };
    };
  };
}
