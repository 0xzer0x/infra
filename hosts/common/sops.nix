{
  sops = {
    defaultSopsFile = ../../secrets/hosts/common.yml;
    age.keyFile = "/var/lib/sops-nix/keys.txt";
    # WARN: Disable importing SSH keys
    age.sshKeyPaths = [ ];
    gnupg.sshKeyPaths = [ ];
  };
}
