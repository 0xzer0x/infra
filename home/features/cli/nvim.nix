{ inputs, config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.nvim;
in {
  options.features.cli.nvim.enable =
    mkEnableOption "Enable Neovim configuration";

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        nixd
        nixfmt
        lua5_1
        lua51Packages.luarocks
        texliveMedium
        sqlite
      ];
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

