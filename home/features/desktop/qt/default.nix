{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.qt;
in {
  options.features.desktop.qt.enable = mkEnableOption "Enable GTK theming";

  imports = [ ./qt5ct.nix ./qt6ct.nix ];

  config = mkIf cfg.enable {
    # NOTE: Disable default catppuccin qt theme
    catppuccin.kvantum.enable = false;
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        name = "Darkly";
        package = with pkgs; [ darkly-qt5 darkly ];
      };
    };

    # NOTE: Fix KDE applications theming and icons
    # Ref: https://github.com/DarkKronicle/nazarick/blob/cd4d87d2399f3025bc618ecf1b5471804010b7a2/modules/home/gui/qt/default.nix#L127
    xdg.configFile."kdeglobals" = {
      enable = true;
      text = lib.generators.toINI { } {
        General = {
          TerminalApplication = config.features.desktop.terminal.default;
        };
        Wallet = { Enabled = false; };
        UiSettings = { ColorScheme = "*"; };
        Icons = { Theme = "Papirus-Dark"; };
      } + (builtins.readFile "${
          pkgs.catppuccin-kde.override {
            flavour = [ "mocha" ];
            accents = [ "blue" ];
          }
        }/share/color-schemes/CatppuccinMochaBlue.colors");
    };
  };
}
