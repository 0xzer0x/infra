{ config, pkgs, inputs, ... }:

{
  imports = [ ./zsh.nix ./starship.nix ];

  home.sessionVariables = {
    # NOTE: XDG data
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    KREW_ROOT = "${config.xdg.dataHome}/krew";

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

  home.packages = with pkgs; [
    inputs.agenix.packages.${system}.default
    file
    bat
    eza
    fzf
    duf
    gum
    fd
    jq
    yq-go
    ripgrep
    fastfetch
    zoxide
    starship
    chezmoi
    lazygit
    kubernetes
    kubecolor
    k9s
    cosign
    htop
    btop
    yazi
    ttyper
    awscli2
    libva-utils
    docker-compose
    lazydocker
    docker-credential-helpers
    dogdns
    lsof
    tealdeer
    go-task
    gopass
    gopass-jsonapi
    git-credential-gopass
    pwgen
    hugo
    terraform
    yt-dlp
  ];
}
