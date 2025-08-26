{ config, inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  networking = {
    hostName = "nixfly";
    networkmanager.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  age.secrets."synapse-wireguard.age".file =
    ../../secrets/synapse-wireguard.age;
  environment.etc.synapse-wireguard-nmconnection = {
    source = config.age.secrets."synapse-wireguard.age".path;
    target = "NetworkManager/system-connections/synapse-wireguard.nmconnection";
  };
}
