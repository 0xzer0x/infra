{ config, lib, ... }:

with lib;
let cfg = config.features.cli.k8s;
in {
  options.features.cli.k8s.enable = mkEnableOption "Enable K8s CLI utilities";

  config = mkIf cfg.enable {
    programs.kubecolor = {
      enable = true;
      enableAlias = true;
      enableZshIntegration = true;
    };

    catppuccin.k9s.transparent = true;
    programs.k9s = {
      enable = true;
      settings = { ui.headless = true; };
    };
  };
}
