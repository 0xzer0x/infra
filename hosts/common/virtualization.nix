{ lib, pkgs, ... }:

{
  # NOTE: Required for cross-compilation of container images
  boot.binfmt = {
    preferStaticEmulators = true;
    emulatedSystems = [ "aarch64-linux" ];
  };

  # NOTE: Virtualization (Docker, Podman, Libvirt)
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        default-runtime = "crun";
        runtimes = {
          crun.path = lib.getExe pkgs.crun;
        };
      };
    };

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--filter=until=24h"
          "--filter=label!=important"
        ];
      };
    };

    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };
}
