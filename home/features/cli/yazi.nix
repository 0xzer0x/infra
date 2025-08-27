{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.yazi;
in {
  options.features.cli.yazi.enable =
    mkEnableOption "Enable Yazi terminal file manager";

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      plugins = {
        mount = pkgs.yaziPlugins.mount;
        no-status = pkgs.yaziPlugins.no-status;
        full-border = pkgs.yaziPlugins.full-border;
      };

      initLua = ''
        local plugins = {
        	"full-border",
        	"no-status",
        	"mount",
        }

        for _, plugin in pairs(plugins) do
        	require(plugin):setup()
        end
      '';

      keymap = {
        mgr.prepend_keymap = [{
          on = [ "g" "w" ];
          run = "cd ~/Workspace";
          desc = "Go to ~/Workspace";
        }];
      };
    };
  };
}
