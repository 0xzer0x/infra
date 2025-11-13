{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.wayland;
  waylandCommonVariables = {
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11,*";
    GDK_SCALE = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_DISABLE_RDD_SANDBOX = 1;
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
in
{
  options.features.desktop.wayland.enable = mkEnableOption "Enable Wayland desktop configuration";

  config = mkIf cfg.enable {
    home.sessionVariables = waylandCommonVariables;
    home.packages = with pkgs; [
      clipman
      wl-clipboard
      wf-recorder
      wlr-randr
      ydotool
      qt6.qtwayland
    ];
  };
}
