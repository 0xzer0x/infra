{ inputs, config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.nvim;
in {
  options.features.cli.nvim.enable =
    mkEnableOption "Enable Neovim configuration";

  config = mkIf cfg.enable {
    # NOTE: Nix LSP (not supported in mason.nvim)
    home.packages = with pkgs; [ nixd ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # NOTE: Disable catppuccin integration, managed through external configuration
    catppuccin.nvim.enable = false;
    xdg.configFile.nvim = {
      source = inputs.nvimdots;
      recursive = true;
    };

    # NOTE: Use as default viewer for man pages
    home.sessionVariables = { MANPAGER = "nvim +Man!"; };
  };
}

