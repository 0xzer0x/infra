{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.synapse;
  hostSecretsConfig = key: {
    sopsFile = ../../secrets/hosts/${config.networking.hostName}.yml;
  };
in {
  options.synapse = {
    wireguard.enable =
      mkEnableOption "Enable Synapse Wireguard network configuration";
  };

  config = mkIf cfg.wireguard.enable {
    sops.secrets = builtins.listToAttrs (builtins.map (secret: {
      name = secret;
      value = hostSecretsConfig secret;
    }) [
      "synapseWireguard/profile"
      "synapseWireguard/dispatcher"
      "synapseWireguard/shadowsocksConfig"
    ]);

    # NOTE: NetworkManager profile
    environment.etc.synapse-wireguard-nmconnection = {
      source = config.sops.secrets."synapseWireguard/profile".path;
      target =
        "NetworkManager/system-connections/synapse-wireguard.nmconnection";
    };

    # NOTE: Dispatcher script
    networking.networkmanager.dispatcherScripts = [{
      type = "basic";
      source = config.sops.secrets."synapseWireguard/dispatcher".path;
    }];
    systemd.services.NetworkManager-dispatcher.path = [ pkgs.bash ];

    # NOTE: ShadowSocks proxy
    environment.systemPackages = [ pkgs.shadowsocks-rust ];
    environment.etc."shadowsocks-rust/config.json" = {
      enable = true;
      source = config.sops.secrets."synapseWireguard/shadowsocksConfig".path;
    };
    systemd.services.shadowsocks-rust = {
      description = "ShadowSocks Proxy server";
      after = [ "network.target" ];
      path = [ pkgs.shadowsocks-rust ];
      script = "exec sslocal -c /etc/shadowsocks-rust/config.json";
    };
  };
}
