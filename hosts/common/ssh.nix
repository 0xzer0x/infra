{
  services.openssh.hostKeys = [{
    type = "ed25519";
    path = "/var/lib/agenix/host.key";
  }];
}
