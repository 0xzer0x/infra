{ config, inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  # NOTE: Generate host agenix key
  services.openssh.hostKeys = [{
    type = "ed25519";
    path = "/var/lib/agenix/host.key";
    comment = "agenix@${config.networking.hostName}";
  }];

  age.identityPaths =
    [ "/var/lib/agenix/master.key" "/var/lib/agenix/host.key" ];
}
