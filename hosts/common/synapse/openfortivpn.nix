{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.work.synapse.openfortivpn;
  openfortiSecret = "networking/synapse-openfortivpn/config";
in
{
  options.work.synapse.openfortivpn.enable =
    lib.mkEnableOption "Enable Synapse OpenfortiVPN configuration";

  config = lib.mkIf cfg.enable {
    sops.secrets.${openfortiSecret} = { };

    environment.systemPackages = with pkgs; [ openfortivpn ];

    environment.etc."openfortivpn/config" = {
      enable = true;
      source = config.sops.secrets.${openfortiSecret}.path;
    };
  };
}
