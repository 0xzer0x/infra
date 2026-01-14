{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.cli.k8s;
in
{
  options.features.cli.k8s.enable = mkEnableOption "Enable K8s CLI utilities";

  config = mkIf cfg.enable {
    # NOTE: Colored kubectl output
    programs.kubecolor = {
      enable = true;
      enableAlias = true;
    };

    # NOTE: TUI
    catppuccin.k9s.transparent = true;
    programs.k9s = {
      enable = true;
      settings = {
        k9s.ui.headless = true;
      };
    };

    # NOTE: Additional packages
    home.packages = with pkgs; [
      kubernetes
      krew
      kubernetes-helm
      minikube
      kind
      k3d
    ];

    # NOTE: Extra environment variables
    home.sessionVariables = {
      KUBECOLOR_CONFIG = lib.mkForce "${config.xdg.configHome}/color.yaml";
      KUBECONFIG = "${config.xdg.configHome}/kube/config";
      KUBECACHEDIR = "${config.xdg.cacheHome}/kube";
      MINIKUBE_HOME = "${config.xdg.configHome}/minikube";
      KREW_ROOT = "${config.xdg.dataHome}/krew";
    };

    # NOTE: Directories to add to PATH
    home.sessionPath = [ "${config.home.sessionVariables.KREW_ROOT}/bin" ];
  };
}
