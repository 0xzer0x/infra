{ config, lib, ... }:

with lib;
let cfg = config.features.cli.fastfetch;
in {
  options.features.cli.fastfetch.enable =
    mkEnableOption "Enable fastfetch configuration";

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "builtin";
          source = "nixos";
        };
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "terminal"
          "display"
          "de"
          "wm"
          "wmtheme"
          "theme"
          "icons"
          "font"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          "localip"
          "battery"
          "poweradapter"
          "separator"
          "colors"
        ];
      };
    };
  };
}

