{ config, lib, ... }:

with lib;
let cfg = config.features.colorscheme;
in {
  options.features.colorscheme.active = mkOption {
    type = types.enum [ "catppuccin" ];
    description = "Colorscheme to use";
    default = "catppuccin";
  };

  imports = [ ./${cfg.active}.nix ];
}
