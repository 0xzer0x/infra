{ config, inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  # NOTE: Generate host agenix key
  services.openssh.hostKeys = [{
    type = "ed25519";
    path = "/var/lib/agenix/host.key";
    comment = "agenix@${config.networking.hostName}";
  }];

  # WARN: Fresh install steps:
  # 1. Copy master agenix key temporarily to host
  # 2. Install system
  # 3. Copy generated host key in /var/lib/agenix/host.key to agenix secrets.nix file
  # 4. Run `agenix -i <path-to-master-key> --rekey` in the secrets directory
  # 5. Remove master agenix key from host
  # 6. Rebuild
  age.identityPaths =
    [ "/var/lib/agenix/host.key" "/var/lib/agenix/youfathy.key" ];
}
