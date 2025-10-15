{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.virtualization;
in {
  options.features.cli.virtualization.enable =
    mkEnableOption "Enable virtualization CLI utilities";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ lima ];
    home.sessionVariables = {
      LIMA_HOME = "${config.xdg.dataHome}/lima";
      # NOTE: Use system-wide QEMU - virsh(1)
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };
  };
}
