{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.programming.go;
in {
  options.features.programming.go.enable =
    mkEnableOption "Enable Go development configuration";

  config = mkIf cfg.enable { home.packages = with pkgs; [ go ]; };
}
