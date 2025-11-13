{ config, lib, ... }:

let
  cfg = config.features.desktop.apps;
in
{
  config = lib.mkIf cfg.enable {
    services.syncthing.settings = {
      devices = {
        younix = {
          id = "KR6ZF5T-4SDU4MF-3M4KD4H-M6IT3YS-4UHUEAC-NTAEEHF-X3UDNAL-QFHFSAC";
          name = "Younix";
        };
      };

      folders.obsidianVault.devices = [ "younix" ];
    };
  };
}
