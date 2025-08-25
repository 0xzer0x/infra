{ pkgs, ... }:

{
  # NOTE: Virtualization (Docker, Podman, Libvirt)
  virtualisation = {
    docker.enable = true;
    podman.enable = true;

    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };
}
