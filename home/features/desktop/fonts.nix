{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.fonts;
in {
  options.features.desktop.fonts.enable =
    mkEnableOption "Enable font configuration";

  config = mkIf cfg.enable { };
}

