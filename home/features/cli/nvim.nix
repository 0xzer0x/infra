{ config, lib, inputs, ... }:

with lib;
let cfg = config.features.cli.nvim;
in {
  options.features.cli.nvim.enable =
    mkEnableOption "Enable Neovim configuration";

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    xdg.configFile.nvim = {
      source = inputs.nvimConfig;
      recursive = true;
    };
  };
}

