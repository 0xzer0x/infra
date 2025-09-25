{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.docker;
in {
  options.features.cli.docker.enable =
    mkEnableOption "Enable Docker CLI utilities";

  config = mkIf cfg.enable {
    programs = {
      docker-cli = {
        enable = true;
        configDir = ".config/docker";
      };
      lazydocker.enable = true;
    };

    home.packages = with pkgs; [
      cosign
      docker-compose
      docker-credential-helpers
    ];
  };
}
