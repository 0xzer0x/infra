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

    # NOTE: Disable catppuccin integration, managed through external configuration
    catppuccin.nvim.enable = false;
    xdg.configFile.nvim = {
      source = inputs.nvimConfig;
      recursive = true;
    };

    # NOTE: Use as default viewer for man pages
    home.sessionVariables = { MANPAGER = "nvim +Man!"; };
  };
}

