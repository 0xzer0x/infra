{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.qt;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kdePackages.qt6ct kdePackages.breeze ];

    xdg.configFile."qt6ct/colors/Catppuccin-Mocha.conf" = {
      enable = true;
      source =
        "${pkgs.catppuccin-qt5ct}/share/qt6ct/colors/catppuccin-mocha-blue.conf";
    };

    xdg.configFile."qt6ct/qt6ct.conf" = {
      text = lib.generators.toINI { } {
        Appearance = {
          style = "Darkly";
          icon_theme = "Papirus-Dark";
          standard_dialogs = "default";
          custom_palette = true;
          color_scheme_path =
            "${config.xdg.configHome}/qt6ct/colors/Catppuccin-Mocha.conf";
        };

        Fonts = {
          fixed = ''"${config.gtk.font.name},10,-1,5,50,0,0,0,0,0"'';
          general = ''"${config.gtk.font.name},10,-1,5,50,0,0,0,0,0"'';
        };

        Interface = {
          activate_item_on_single_click = 1;
          buttonbox_layout = 3;
          cursor_flash_time = 1200;
          dialog_buttons_have_icons = 1;
          double_click_interval = 400;
          gui_effects = "General";
          keyboard_scheme = 2;
          menus_have_icons = true;
          show_shortcuts_in_context_menus = true;
          stylesheets = "@Invalid()";
          toolbutton_style = 4;
          underline_shortcut = 1;
          wheel_scroll_lines = 3;
        };

        SettingsWindow = {
          geometry =
            "@ByteArray(\\x1\\xd9\\xd0\\xcb\\0\\x3\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\a\\x7f\\0\\0\\x4\\x1b\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\a\\x7f\\0\\0\\x4\\x37\\0\\0\\0\\0\\x2\\0\\0\\0\\a\\x80\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\a\\x7f\\0\\0\\x4\\x1b)";
        };

        Troubleshooting = {
          force_raster_widgets = 1;
          ignored_applications = "@Invalid()";
        };
      };
    };
  };
}
