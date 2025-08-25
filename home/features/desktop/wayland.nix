{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.wayland;
in {
  options.features.desktop.wayland.enable =
    mkEnableOption "Enable Wayland desktop configuration";

  config = mkIf cfg.enable {
    home.sessionVariables = { NIXOS_OZONE_WL = "1"; };
    home.packages = with pkgs; [
      swww
      grim
      slurp
      clipman
      wl-clipboard
      wf-recorder
      wlr-randr
      ydotool
      qt6.qtwayland
    ];
  };
}
