{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.terminal;
in
{
  options.features.desktop.terminal.foot.enable = mkOption {
    type = types.bool;
    description = "Enable Foot terminal configuration";
    default = cfg.default == "foot";
  };

  config = mkIf cfg.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          shell = "tmux";
          font = "monospace:size=11";
        };
      };
    };
  };
}
