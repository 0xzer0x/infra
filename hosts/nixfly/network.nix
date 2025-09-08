{ config, lib, ... }:

let
  inherit (config.networking) hostName;
  homeWifiSSID = "Pluto";
  homeWifiSecret = "networking/home-wifi/psk";
  synapseWifiSSID = "Synapse Analytics";
  synapseWifiSecret = "networking/synapse-wifi/psk";
  wifiProfile = { wifiSSID, pskVar, hiddenSSID }: {
    connection = {
      id = wifiSSID;
      type = "802-11-wireless";
      autoconnect = true;
    };

    ipv4 = { method = "auto"; };

    wifi = {
      hidden = hiddenSSID;
      ssid = wifiSSID;
      mode = "infrastructure";
    };

    wifi-security = {
      key-mgmt = "wpa-psk";
      psk = "\$${pskVar}";
    };
  };
in {
  sops.secrets = {
    "${homeWifiSecret}" = { };
    "${synapseWifiSecret}" = {
      sopsFile = ../../secrets/hosts/${hostName}.yml;
    };
  };
  sops.templates."networkmanager-${hostName}.env".content = ''
    HOMEWIFIPSK=${config.sops.placeholder."${homeWifiSecret}"}
    SYNAPSEWIFIPSK=${config.sops.placeholder."${synapseWifiSecret}"}
  '';

  networking.networkmanager.ensureProfiles = {
    environmentFiles =
      [ config.sops.templates."networkmanager-${hostName}.env".path ];
    profiles = {
      home-wifi = wifiProfile {
        hiddenSSID = true;
        wifiSSID = homeWifiSSID;
        pskVar = "HOMEWIFIPSK";
      };

      synapse-wifi = wifiProfile {
        hiddenSSID = false;
        wifiSSID = synapseWifiSSID;
        pskVar = "SYNAPSEWIFIPSK";
      };
    };
  };
}
