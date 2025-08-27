{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.wayland;
in {
  options.features.desktop.wayland.enable =
    mkEnableOption "Enable Wayland desktop configuration";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11,*";
      GDK_SCALE = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      MOZ_ENABLE_WAYLAND = 1;
      MOZ_DISABLE_RDD_SANDBOX = 1;
    };

    home.packages = with pkgs; [
      grim
      slurp
      clipman
      wl-clipboard
      wf-recorder
      wlr-randr
      ydotool
      qt6.qtwayland
    ];

    # NOTE: Set wayland version for rofi home-manager config
    programs.rofi.package = pkgs.rofi-wayland;
  };
}
