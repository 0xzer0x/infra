{ inputs, config, lib, ... }:

let cfg = config.features.colorscheme;
in {
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  config = lib.mkIf (cfg.active == "catppuccin") {
    catppuccin = {
      enable = true;
      accent = "blue";
      flavor = "mocha";
    };
  };
}
