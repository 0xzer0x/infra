{
  sops = {
    defaultSopsFile = ../../secrets/hosts/common.yml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
  };
}
