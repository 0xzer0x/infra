{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.aws;
in {
  options.features.cli.aws.enable = mkEnableOption "Enable AWS CLI utilities";

  config = mkIf cfg.enable {
    # NOTE: Official AWS CLI
    programs.awscli = {
      enable = true;
      package = pkgs.awscli2;
    };

    sops.secrets.aws-config = { };
    sops.templates."${config.home.username}-aws-config" = {
      content = config.sops.placeholder.aws-config;
      path = "${config.home.homeDirectory}/.aws/config";
    };

    # NOTE: Additional packages
    home.packages = with pkgs; [ terraform ];

    # NOTE: Extra environment variables
    home.sessionVariables = { AWS_PROFILE = "personal"; };
  };
}
