{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.work.synapse.wireguard;
  connId = "synapse-wireguard";
  peerPubkey = "If0266OV2xuoVLBtKjj4JCMFkPgcZ4HKILKx8VjtIns=";
  secretPath = name: "networking/synapse-wireguard/${name}";
  requiredSecrets = builtins.map secretPath [
    "private-key"
    "wireguard-peer/endpoint"
    "wireguard-peer/psk"
    "wireguard-peer/allowed-ips"
    "ipv4/addresses"
    "dispatcher"
    "shadowsocks-config"
  ];
in {
  options.work.synapse.wireguard.enable =
    mkEnableOption "Enable Synapse Wireguard network configuration";

  config = mkIf cfg.enable {
    sops.secrets = genAttrs requiredSecrets (name: { });
    sops.templates."synapse-wireguard.env".content = ''
      SYNAPSE_WIREGUARD_PRIVATE_KEY=${
        config.sops.placeholder.${secretPath "private-key"}
      }
      SYNAPSE_WIREGUARD_ENDPOINT=${
        config.sops.placeholder.${secretPath "wireguard-peer/endpoint"}
      }
      SYNAPSE_WIREGUARD_PSK=${
        config.sops.placeholder.${secretPath "wireguard-peer/psk"}
      }
      SYNAPSE_WIREGUARD_ALLOWED_IPS=${
        config.sops.placeholder.${secretPath "wireguard-peer/allowed-ips"}
      }
      SYNAPSE_WIREGUARD_IPV4_ADDRESSES=${
        config.sops.placeholder.${secretPath "ipv4/addresses"}
      }
    '';

    networking.networkmanager = {
      # NOTE: NetworkManager profile
      ensureProfiles = {
        environmentFiles =
          [ config.sops.templates."synapse-wireguard.env".path ];
        profiles.synapse-wireguard = {
          connection = {
            id = connId;
            type = "wireguard";
            autoconnect = false;
            interface-name = "wg0";
          };

          wireguard = {
            mtu = 1360;
            private-key = "$SYNAPSE_WIREGUARD_PRIVATE_KEY";
          };

          "wireguard-peer.${peerPubkey}" = {
            endpoint = "$SYNAPSE_WIREGUARD_ENDPOINT";
            allowed-ips = "$SYNAPSE_WIREGUARD_ALLOWED_IPS";
            preshared-key = "$SYNAPSE_WIREGUARD_PSK";
            preshared-key-flags = 0;
          };

          ipv4 = {
            method = "manual";
            addresses = "$SYNAPSE_WIREGUARD_IPV4_ADDRESSES";
            dns = "1.1.1.3;1.0.0.3;";
            dns-search = "~";
          };

          ipv6 = { method = "disabled"; };
        };
      };

      # NOTE: Dispatcher script
      dispatcherScripts = [{
        type = "basic";
        source = config.sops.secrets.${secretPath "dispatcher"}.path;
      }];
    };
    systemd.services.NetworkManager-dispatcher.path = [ pkgs.bash ];

    # NOTE: ShadowSocks proxy
    environment.systemPackages = [ pkgs.shadowsocks-rust ];
    environment.etc."shadowsocks-rust/config.json" = {
      enable = true;
      source = config.sops.secrets.${secretPath "shadowsocks-config"}.path;
    };
    systemd.services.shadowsocks-rust = {
      description = "ShadowSocks Proxy server";
      after = [ "network.target" ];
      path = [ pkgs.shadowsocks-rust ];
      script = "exec sslocal -c /etc/shadowsocks-rust/config.json";
    };
  };
}
