{ pkgs, inputs, ... }:

{
  imports = [ ./env.nix ./zsh.nix ./starship.nix ./gnupg.nix ];

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
    pinentry-qt
    pwgen
    hugo
    terraform
    ansible
    yt-dlp
    libisoburn
  ];
}
