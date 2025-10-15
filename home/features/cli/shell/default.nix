{ lib, ... }:

{
  imports = [ ./zsh.nix ./fish.nix ];

  options.features.cli.shell.default = lib.mkOption {
    type = lib.types.enum [ "zsh" "fish" ];
    description = "Default shell";
    default = "zsh";
  };
}
