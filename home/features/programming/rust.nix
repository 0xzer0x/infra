{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.programming.rust;
in {
  options.features.programming.rust.enable =
    mkEnableOption "Enable Rust development configuration";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rustup ];
    home.sessionVariables = {
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    };
    home.sessionPath = [ "${config.home.sessionVariables.CARGO_HOME}/bin" ];
  };
}
