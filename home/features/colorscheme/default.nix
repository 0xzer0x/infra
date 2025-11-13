{ lib, ... }:

with lib;
{
  options.features.colorscheme.active = mkOption {
    type = types.enum [ "catppuccin" ];
    description = "Colorscheme to use";
    default = "catppuccin";
  };

  imports = [ ./catppuccin.nix ];
}
