{ config, lib, ... }:

with lib;
let cfg = config.features.cli.ssh;
in {
  options.features.cli.ssh.enable =
    mkEnableOption "Enable SSH client configuration";

  config = mkIf cfg.enable {
    sops.secrets.ssh-config = { };

    sops.templates."${config.home.username}-sshconfig" = {
      content = config.sops.placeholder.ssh-config;
      path = "${config.home.homeDirectory}/.ssh/config.d/default";
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      includes = [ "~/.ssh/config.d/default" ];
    };
  };
}
