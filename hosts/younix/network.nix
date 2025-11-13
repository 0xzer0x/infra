{ config, ... }:

let
  inherit (config.networking) hostName;
  homeWifiSSID = "Pluto";
  homeWifiSecret = "networking/home-wifi/psk";
in
{
  sops.secrets."${homeWifiSecret}" = { };
  sops.templates."networkmanager-${hostName}.env".content = ''
    HOMEWIFIPSK=${config.sops.placeholder."${homeWifiSecret}"}
  '';

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.templates."networkmanager-${hostName}.env".path ];
    profiles = {
      ethernet = {
        connection = {
          id = "Ethernet";
          type = "802-3-ethernet";
          autoconnect = true;
          autoconnect-priority = 10;
        };

        ipv4 = {
          method = "auto";
        };
      };

      home-wifi = {
        connection = {
          id = homeWifiSSID;
          type = "802-11-wireless";
          autoconnect = true;
        };

        ipv4 = {
          method = "auto";
        };

        wifi = {
          hidden = true;
          ssid = homeWifiSSID;
          mode = "infrastructure";
        };

        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$HOMEWIFIPSK";
        };
      };
    };
  };
}
