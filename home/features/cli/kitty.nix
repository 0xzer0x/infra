{ config, lib, ... }:

with lib;
let cfg = config.features.cli.kitty;
in {
  options.features.cli.kitty.enable =
    mkEnableOption "Enable kitty terminal configuration";

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "monospace";
        size = 11;
      };
    };
  };
}

