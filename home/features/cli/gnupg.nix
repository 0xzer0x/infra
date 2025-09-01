{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.gnupg;
in {
  options.features.cli.gnupg.enable = mkEnableOption "Enable GPG configuration";

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-qt;
    };
  };
}
