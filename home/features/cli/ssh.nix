{ config, lib, ... }:

with lib;
let cfg = config.features.cli.ssh;
in {
  options.features.cli.ssh.enable =
    mkEnableOption "Enable SSH client configuration";

  config = mkIf cfg.enable {
    sops.secrets.sshConfig = { };

    sops.templates."${config.home.username}-sshconfig" = {
      content = config.sops.placeholder.sshConfig;
      path = "${config.home.homeDirectory}/.ssh/config.d/default";
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      includes = [ "~/.ssh/config.d/default" ];
    };
  };
}
