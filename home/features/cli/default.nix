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
    ./aws.nix
    ./ansible.nix
    ./docker.nix
    ./multimedia.nix
  ];

  # NOTE: Use programs.<name>.enable whenever possible instead of using home.packages
  programs = {
    fd.enable = true;
    jq.enable = true;
    bat.enable = true;
    btop.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    nix-index.enable = true;
  };

  home.packages = with pkgs; [
    inputs.agenix.packages.${system}.default
    file
    procps
    duf
    gum
    yq-go
    ttyper
    libva-utils
    dogdns
    lsof
    go-task
    pinentry-qt
    pwgen
    openssl
    sshpass
  ];
}
