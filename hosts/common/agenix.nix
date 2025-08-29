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
  # 1. Install system (agenix will give you warnings but no errors)
  # 3. Copy generated host key in /var/lib/agenix/host.key to agenix secrets.nix file
  # 4. Run `agenix -i <path-to-master-key> --rekey` in the secrets directory
  # 5. Pull updated flake in host
  # 6. Rebuild
  age.identityPaths = [ "/var/lib/agenix/host.key" "/var/lib/agenix/master.key" ];
}
