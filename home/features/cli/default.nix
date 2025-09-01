{ pkgs, inputs, ... }:

{
  imports = [
    ./tmux
    ./scripts
    ./go-pray
    ./env.nix
    ./kitty.nix
    ./zsh.nix
    ./starship.nix
    ./nvim.nix
    ./fastfetch.nix
    ./gnupg.nix
    ./gopass.nix
    ./git.nix
    ./k8s.nix
    ./yazi.nix
  ];

  # NOTE: Use programs.<name>.enable whenever possible instead of using home.packages
  programs = {
    awscli.enable = true;
    bat.enable = true;
    btop.enable = true;
    htop.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    lazygit.enable = true;
    lazydocker.enable = true;
    jq.enable = true;
    yt-dlp.enable = true;
    nix-index.enable = true;
  };

  home.packages = with pkgs; [
    inputs.agenix.packages.${system}.default
    file
    procps
    duf
    gum
    yq-go
    chezmoi
    kubernetes
    cosign
    ttyper
    libva-utils
    docker-compose
    docker-credential-helpers
    dogdns
    lsof
    go-task
    pinentry-qt
    pwgen
    hugo
    terraform
    ansible
    libisoburn
    openssl
    sshpass
  ];
}
