{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.waybar;
in {
  options.features.desktop.waybar.enable =
    mkEnableOption "Enable Waybar extended configuration";

  imports = [ ./builtins.nix ./custom.nix ];

  config = mkIf cfg.enable {
    xdg.configFile."waybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };

    # NOTE: Disable catppucin's Waybar configuration
    catppuccin.waybar.enable = mkForce false;
    xdg.configFile."waybar/catppuccin-mocha.css" = {
      source = ./catppuccin-mocha.css;
    };

    home.packages = with pkgs; [ networkmanagerapplet libappindicator ];

    programs.waybar = {
      enable = true;
      style = ./style.css;
      settings.hyprland-statusbar = {
        layer = "top";
        height = 28;
        spacing = 4;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "custom/record-status"
          "hyprland/window"
        ];
      };
    };
  };
}
