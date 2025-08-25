{ inputs, ... }:

{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  config.catppuccin = {
    enable = true;
    accent = "blue";
    flavor = "mocha";
  };
}
