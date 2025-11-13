{ config, lib, ... }:

let
  cfg = config.features.desktop.apps;
in
{
  config = lib.mkIf cfg.enable {
    services.syncthing.settings = {
      devices = {
        nixfly = {
          id = "7UO7W73-LYFRTQ3-3RQJVME-54ROKDQ-VXYVNJV-TQOGRBI-YHDJO4E-YRSMSAC";
          name = "Nixfly";
        };
      };

      folders.obsidianVault.devices = [ "nixfly" ];
    };
  };
}
