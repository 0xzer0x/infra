{ lib, ... }:

with lib; {
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };

  # NOTE: Disable nested virtualization
  virtualisation = {
    spiceUSBRedirection.enable = mkForce false;
    libvirtd.enable = mkForce false;
  };
}
