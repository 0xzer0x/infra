{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.terminal;

in
{
  imports = [
    ./kitty.nix
    ./foot.nix
    ./alacritty.nix
    ./ghostty.nix
  ];

  options.features.desktop.terminal.default = mkOption {
    type = types.enum [
      "kitty"
      "foot"
      "alacritty"
      "ghostty"
    ];
    description = "Name of default terminal program";
    default = "kitty";
  };

  config = {
    home.sessionVariables.TERM_PROGRAM = cfg.default;
  };
}
