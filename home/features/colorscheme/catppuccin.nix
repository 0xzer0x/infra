{ config, inputs, ... }:

let cfg = config.features.colorscheme;
in {
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  config.catppuccin = {
    enable = cfg.active == "catppuccin";
    accent = "blue";
    flavor = "mocha";
  };
}
