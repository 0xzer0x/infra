{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.programming.nodejs;
in {
  options.features.programming.nodejs.enable =
    mkEnableOption "Enable NodeJS development configuration";

  config = mkIf cfg.enable { home.packages = with pkgs; [ nodejs_24 ]; };
}

