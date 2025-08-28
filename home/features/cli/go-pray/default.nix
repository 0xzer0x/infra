{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.go-pray;
in {
  options.features.cli.go-pray.enable =
    mkEnableOption "Enable go-pray CLI configuration";

  config = mkIf cfg.enable {
    xdg.configFile."go-pray/qatami-takbeer.mp3" = {
      source = ./qatami-takbeer.mp3;
    };

    services.go-pray = {
      enable = true;

      settings = ''
        language: en
        adhan: ${config.xdg.configHome}/go-pray/qatami-takbeer.mp3
        timezone: Africa/Cairo
        calculation:
          method: EGYPT
        location:
          lat: 30.001780
          long: 31.290419
        notification:
          icon: xclock
          title: Prayer Time
          body: Time for {{ .CalendarName }} prayer 🕌
      '';
    };
  };
}
