{ config, inputs, pkgs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  age.secrets = {
    "synapse-wireguard.age".file = ../../secrets/synapse-wireguard.age;
    "synapse-wireguard-dispatcher.age".file =
      ../../secrets/synapse-wireguard-dispatcher.age;
  };

  environment.etc.synapse-wireguard-nmconnection = {
    source = config.age.secrets."synapse-wireguard.age".path;
    target = "NetworkManager/system-connections/synapse-wireguard.nmconnection";
  };

  networking.networkmanager.dispatcherScripts = [{
    type = "basic";
    source = config.age.secrets."synapse-wireguard-dispatcher.age".path;
  }];
  systemd.services.NetworkManager-dispatcher.path = [ pkgs.bash ];
}
