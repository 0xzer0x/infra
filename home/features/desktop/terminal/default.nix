{ config, lib, ... }:

with lib;
let cfg = config.features.desktop.terminal;

in {
  imports = [ ./kitty.nix ./foot.nix ];

  options.features.desktop.terminal.default = mkOption {
    type = types.str;
    description = "Name of default terminal program";
    default = "kitty";
  };

  config = { home.sessionVariables.TERM_PROGRAM = cfg.default; };
}

