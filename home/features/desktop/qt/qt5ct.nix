{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.qt;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ libsForQt5.qt5ct ];

    xdg.configFile."qt5ct/colors/Catppuccin-Mocha.conf" = {
      source = ./config/Catppuccin-Mocha.conf;
    };

    xdg.configFile."qt5ct/qt5ct.conf" = {
      text = ''
        [Appearance]
        color_scheme_path=${config.xdg.configHome}/qt5ct/colors/Catppuccin-Mocha.conf
        custom_palette=true
        icon_theme=${config.gtk.iconTheme.name}
        standard_dialogs=default
        style=Breeze

        [Fonts]
        fixed="${config.gtk.font.name},10,-1,5,50,0,0,0,0,0"
        general="${config.gtk.font.name},10,-1,5,50,0,0,0,0,0"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=3
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [QSSEditor]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x4^\0\0\x1Z\0\0\x6\xe2\0\0\x3N\0\0\x4_\0\0\x1[\0\0\x6\xe1\0\0\x3M\0\0\0\0\0\0\0\0\a\x80\0\0\x4_\0\0\x1[\0\0\x6\xe1\0\0\x3M)

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\a\x7f\0\0\x4\x1b\0\0\0\0\0\0\0\0\0\0\a\x7f\0\0\x4\x37\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\a\x7f\0\0\x4\x1b)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
      '';
    };
  };
}
