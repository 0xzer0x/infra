{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.ansible;
in {
  options.features.cli.ansible.enable =
    mkEnableOption "Enable Ansible CLI utilities";

  config = mkIf cfg.enable {
    # NOTE: Additional packages
    home.packages = with pkgs; [ ansible ];

    # NOTE: Extra environment variables
    home.sessionVariables = {
      ANISBLE_HOME = "${config.xdg.configHome}/ansible";
    };
  };
}
