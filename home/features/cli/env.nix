{ config, ... }:

{
  home.sessionVariables = {
    # NOTE: XDG data
    KREW_ROOT = "${config.xdg.dataHome}/krew";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    GOPATH = "${config.xdg.dataHome}/go";

    # NOTE: XDG config
    NIXOS_SYSTEM_FLAKE = "${config.xdg.configHome}/younix";
    ANISBLE_HOME = "${config.xdg.configHome}/ansible";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    KUBECONFIG = "${config.xdg.configHome}/kube/config";
    MINIKUBE_HOME = "${config.xdg.configHome}/minikube";
    FFMPEG_DATADIR = "${config.xdg.configHome}/ffmpeg";
    GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    KDEHOME = "${config.xdg.configHome}/kde";
    LESSKEY = "${config.xdg.configHome}/less/lesskey";
    VAGRANT_HOME = "${config.xdg.configHome}/vagrant";
    VIMDOTDIR = "${config.xdg.configHome}/vim";

    # NOTE: XDG cache
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    KUBECACHEDIR = "${config.xdg.cacheHome}/kube";

    # NOTE: Defaults
    VIDEO = "mpv";
    EDITOR = "nvim";
    TERM_PROGRAM = "kitty";
    MANPAGER = "nvim +Man!";

    # NOTE: AWS
    AWS_PROFILE = "personal";
  };

  # NOTE: Directories to add to PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.local/usr/bin"
    "${config.home.sessionVariables.GOPATH}/bin"
    "${config.home.sessionVariables.CARGO_HOME}/bin"
    "${config.home.sessionVariables.KREW_ROOT}/bin"
  ];
}
