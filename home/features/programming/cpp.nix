{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.programming.cpp;
in {
  options.features.programming.cpp.enable =
    mkEnableOption "Enable C/C++ development configuration";

  config = mkIf cfg.enable { home.packages = with pkgs; [ gnumake cmake ]; };
}
