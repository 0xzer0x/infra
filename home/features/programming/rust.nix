{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.programming.rust;
in {
  options.features.programming.rust.enable =
    mkEnableOption "Enable Rust development configuration";

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ rustc cargo rustup ]; };
}
