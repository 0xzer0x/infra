{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.cli.containers;
in
{
  options.features.cli.containers.enable = mkEnableOption "Enable containers CLI utilities";

  config = mkIf cfg.enable {
    programs = {
      docker-cli = {
        enable = true;
        configDir = ".config/docker";
      };
      lazydocker.enable = true;
    };

    home.packages = with pkgs; [
      stable.cosign
      dive
      docker-compose
      docker-credential-helpers
      podman-compose
      buildah
      skopeo
    ];
  };
}
