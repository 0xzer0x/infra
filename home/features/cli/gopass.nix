{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.gopass;
in {
  options.features.cli.gopass.enable =
    mkEnableOption "Enable Gopass configuration";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gopass
      gopass-jsonapi
      git-credential-gopass
      passff-host
    ];

    xdg.configFile."gopass/config" = {
      text = ''
        [core]
        autopush = false
        autosync = false
        cliptimeout = 0

        [mounts]
        path = ${config.xdg.dataHome}/gopass/stores/root
      '';
    };
  };
}

