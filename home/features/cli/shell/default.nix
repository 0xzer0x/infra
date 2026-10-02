{ lib, ... }:

{
  imports = [
    ./zsh.nix
    ./fish.nix
  ];

  options.features.cli.shell.default = lib.mkOption {
    description = "Default shell interpreter";
    default = "fish";
    type = lib.types.enum [
      "zsh"
      "fish"
    ];
  };
}
