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
        name = "breeze";
        package = pkgs.kdePackages.breeze;
      };
    };
  };
}
